local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "url-markdown" })
end

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function normalize_url(url)
  local cleaned = trim(url)

  if cleaned:match("^%a[%w+.-]*://") then
    return cleaned
  end

  if cleaned:match("^//") then
    return "https:" .. cleaned
  end

  return "https://" .. cleaned
end

local function extract_host(url)
  local normalized = normalize_url(url)
  local host = normalized:match("^%a[%w+.-]*://([^/%?#]+)") or ""
  host = host:gsub(":%d+$", "")
  host = host:gsub("^www%.", "")
  return host:lower()
end

local function html_entity_decode(s)
  local entities = {
    ["&amp;"] = "&",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&quot;"] = '"',
    ["&#39;"] = "'",
    ["&apos;"] = "'",
    ["&nbsp;"] = " ",
  }

  s = s:gsub("&#x(%x+);", function(hex)
    return vim.fn.nr2char(tonumber(hex, 16))
  end)

  s = s:gsub("&#(%d+);", function(dec)
    return vim.fn.nr2char(tonumber(dec, 10))
  end)

  for entity, value in pairs(entities) do
    s = s:gsub(entity, value)
  end

  return s
end

local function extract_title(html)
  local title = html:match("<[Tt][Ii][Tt][Ll][Ee][^>]*>(.-)</[Tt][Ii][Tt][Ll][Ee]>")
  if not title then
    return nil
  end

  title = html_entity_decode(title)
  title = title:gsub("%s+", " ")
  return trim(title)
end

local function beautify_title(title, host)
  local cleaned = trim(title)

  cleaned = cleaned:gsub("^Ask HN:%s*", "")
  cleaned = cleaned:gsub("^Show HN:%s*", "")
  cleaned = cleaned:gsub("^Tell HN:%s*", "")
  cleaned = cleaned:gsub("^Launch HN:%s*", "")

  if host == "github.com" then
    cleaned = cleaned:gsub("^GitHub%s+%-+%s*", "")
    cleaned = cleaned:gsub("%s*·%s*GitHub$", "")
    cleaned = cleaned:gsub("^([^:]+):%s*", "")
  elseif host == "youtube.com" or host == "www.youtube.com" then
    cleaned = cleaned:gsub("%s*%-+%s*YouTube$", "")
  elseif host == "stackoverflow.com" or host:match("%.stackexchange%.com$") then
    cleaned = cleaned:gsub("^.-%-%s+", "")
    cleaned = cleaned:gsub("%s+%-%s+.-$", "")
  elseif host == "manning.com" then
    cleaned = cleaned:gsub("^.-[%-%|:]%s+", "")
  else
    cleaned = cleaned:gsub("%s+[|·•:]%s+[^|·•:]+$", "")
    cleaned = cleaned:gsub("%s+[%-%–—]%s+[^%-%–—]+$", "")
  end

  cleaned = cleaned:gsub("%s+[%|·•%-%–—:]%s*" .. vim.pesc(host) .. "$", "")
  cleaned = cleaned:gsub("%s+[%|·•%-%–—:]%s*" .. vim.pesc(host:gsub("^www%.", "")) .. "$", "")
  cleaned = cleaned:gsub("%s+", " ")
  cleaned = trim(cleaned)

  return cleaned ~= "" and cleaned or trim(title)
end

local function markdown_escape_title(title)
  return title:gsub("([%[%]])", "\\%1")
end

local function current_line_markdown_link()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  local title, url = line:match("^%s*%[(.-)%]%((.-)%)%s*$")
  if not title or not url then
    return nil, row, line
  end

  return { title = title, url = url, row = row, line = line }
end

local function replace_current_link_title_with_original()
  local original_title = vim.b.url_markdown_original_title
  if not original_title or trim(original_title) == "" then
    notify("No saved original title in this buffer", vim.log.levels.ERROR)
    return true
  end

  local link = current_line_markdown_link()
  if not link then
    return false
  end

  local replacement = string.format("[%s](%s)", markdown_escape_title(trim(original_title)), link.url)
  vim.api.nvim_buf_set_lines(0, link.row - 1, link.row, false, { replacement })
  notify("Replaced link title with original title: " .. original_title)
  return true
end

local function store_original_title(title)
  vim.b.url_markdown_original_title = title
end

local function make_markdown(url, title, opts)
  opts = opts or {}
  local host = extract_host(url)
  local link_title = opts.use_original and trim(title) or beautify_title(title, host)

  if not opts.use_original then
    if host == "developer.mozilla.org" then
      link_title = "MDN: " .. link_title
    elseif host == "youtube.com" or host == "youtu.be" then
      link_title = "YouTube: " .. link_title
    end
  end

  return string.format("[%s](%s)", markdown_escape_title(link_title), normalize_url(url))
end

local function fetch_title_async(url, callback)
  local normalized = normalize_url(url)

  local ok, cmd_or_err = pcall(vim.system, {
    "curl",
    "-q",
    "-L",
    "--compressed",
    "--silent",
    "--max-time",
    "15",
    normalized,
  }, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        local err = trim(result.stderr or "")
        if err == "" then
          err = "curl exited with code " .. result.code
        end
        callback(nil, err, normalized)
        return
      end

      local title = extract_title(result.stdout or "")
      if not title or title == "" then
        callback(nil, "could not extract <title>", normalized)
        return
      end

      callback(title, nil, normalized)
    end)
  end)

  if not ok then
    vim.schedule(function()
      callback(nil, tostring(cmd_or_err), normalized)
    end)
  end
end

local function get_visual_selection()
  local mode = vim.fn.visualmode()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines == 0 then
    return nil
  end

  if mode == "V" then
    return {
      mode = "line",
      start_row = start_row,
      end_row = end_row,
      lines = lines,
    }
  end

  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)

  return {
    mode = (#lines == 1) and "char" or "block",
    start_row = start_row,
    end_row = end_row,
    start_col = start_col,
    end_col = end_col,
    lines = lines,
    text = trim(table.concat(lines, "\n")),
  }
end

local function replace_visual_charwise(sel, replacement)
  local line = vim.api.nvim_buf_get_lines(0, sel.start_row - 1, sel.start_row, false)[1] or ""
  local before = string.sub(line, 1, sel.start_col - 1)
  local after = string.sub(line, sel.end_col + 1)
  vim.api.nvim_buf_set_lines(0, sel.start_row - 1, sel.start_row, false, { before .. replacement .. after })
end

local function transform_lines(bufnr, start_row, lines, opts)
  opts = opts or {}
  local pending = 0
  local outputs = vim.deepcopy(lines)

  for index, line in ipairs(lines) do
    local url = trim(line)
    if url ~= "" then
      pending = pending + 1
      fetch_title_async(url, function(title, err, normalized)
        if title then
          outputs[index] = make_markdown(normalized, title, opts)
          store_original_title(title)
        else
          outputs[index] = line
          notify("Could not extract title for " .. normalized .. ": " .. err, vim.log.levels.ERROR)
        end

        pending = pending - 1
        if pending ~= 0 then
          return
        end

        vim.api.nvim_buf_set_lines(bufnr, start_row - 1, start_row - 1 + #lines, false, outputs)

        local generated = 0
        for i, original in ipairs(lines) do
          if trim(original) ~= "" and outputs[i] ~= original then
            generated = generated + 1
          end
        end
        notify("Generated " .. generated .. " Markdown link(s). Original title: " .. vim.b.url_markdown_original_title)
      end)
    end
  end

  if pending == 0 then
    notify("No URLs selected", vim.log.levels.WARN)
    return
  end

  notify("Fetching titles...", vim.log.levels.INFO)
end

function M.link_current_line(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local original = trim(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or "")

  if original == "" then
    notify("Current line is empty", vim.log.levels.ERROR)
    return
  end

  notify("Fetching title...", vim.log.levels.INFO)
  fetch_title_async(original, function(title, err, normalized)
    if not title then
      notify("Could not extract title for " .. normalized .. ": " .. err, vim.log.levels.ERROR)
      return
    end

    store_original_title(title)
    vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, { make_markdown(normalized, title, opts) })
    notify("Generated Markdown link. Original title: " .. title)
  end)
end

function M.link_visual_selection(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()
  local sel = get_visual_selection()

  if not sel then
    notify("Selection is empty", vim.log.levels.ERROR)
    return
  end

  if sel.mode == "char" then
    if sel.text == "" then
      notify("Selection is empty", vim.log.levels.ERROR)
      return
    end

    notify("Fetching title...", vim.log.levels.INFO)
    fetch_title_async(sel.text, function(title, err, normalized)
      if not title then
        notify("Could not extract title for " .. normalized .. ": " .. err, vim.log.levels.ERROR)
        return
      end

      store_original_title(title)
      replace_visual_charwise(sel, make_markdown(normalized, title, opts))
      notify("Generated Markdown link. Original title: " .. title)
    end)
    return
  end

  transform_lines(bufnr, sel.start_row, sel.lines, opts)
end

vim.keymap.set("n", "<leader>u", function()
  M.link_current_line()
end, {
  remap = false,
  silent = false,
  desc = "Turn URL on current line into a Markdown link",
})

vim.keymap.set("n", "<leader>U", function()
  if replace_current_link_title_with_original() then
    return
  end
  M.link_current_line({ use_original = true })
end, {
  remap = false,
  silent = false,
  desc = "Turn URL on current line into a Markdown link using original title",
})

vim.keymap.set("x", "<leader>u", function()
  vim.schedule(function()
    M.link_visual_selection()
  end)
end, {
  remap = false,
  silent = true,
  desc = "Turn selected URL(s) into Markdown links",
})

vim.keymap.set("x", "<leader>U", function()
  vim.schedule(function()
    M.link_visual_selection({ use_original = true })
  end)
end, {
  remap = false,
  silent = true,
  desc = "Turn selected URL(s) into Markdown links using original titles",
})

return M
