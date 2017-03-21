module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 17,

    // font family with optional fallbacks
    fontFamily: 'Hack, Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color (hex)
    cursorColor: '#d8d8d8',

    cursorBlink: true,

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // color of the text
    foregroundColor: '#d8d8d8',

    // terminal background color
    backgroundColor: '#181818',

    // border color (window, tabs)
    borderColor: '#333',

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '0px 0px',

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    colors: [
      '#181818',
      '#ab4642',
      '#a1b56c',
      '#f7ca88',
      '#7cafc2',
      '#ba8baf',
      '#86c1b9',
      '#d8d8d8',
      '#585858',
      '#ab4642',
      '#a1b56c',
      '#f7ca88',
      '#7cafc2',
      '#ba8baf',
      '#86c1b9',
      '#f8f8f8',

      // Default colors:
      //'#000000',
      //'#ff0000',
      //'#33ff00',
      //'#ffff00',
      //'#0066ff',
      //'#cc00ff',
      //'#00ffff',
      //'#d0d0d0',
      //'#808080',
      //'#ff0000',
      //'#33ff00',
      //'#ffff00',
      //'#0066ff',
      //'#cc00ff',
      //'#00ffff',
      //'#ffffff'

    ],

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: 'fish',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    //shellArgs: ['--login'],
    shellArgs: [],

    // for environment variables
    env: {},

    // set to false for no bell
    //bell: 'SOUND',
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    showHamburgerMenu: true,

    showWindowControls: false,

    //modifierKeys: {
    //  cmdIsMeta: false,
    //  altIsMeta: false,
    //}

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    //'hyper-blink',
    'hyperlinks',
    //'hypercwd',
    //'hyperterm-alternatescroll',
    //'hyper-statusline',
    'hyper-tab-icons',
    //'hyper-tabs-enhanced',
    //'hyperpunk',
    //'hyperpower',
    //'hyperterm-retro',
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
