import socket
import os
import subprocess
import struct
import json
import array
import sys

ipc_magic = b'i3-ipc'
chunk_size = 1024

fmt_header = '<{}sii'.format(len(ipc_magic))
fmt_header_size = struct.calcsize(fmt_header)


def i3pack(message_type, payload='', ipc_magic=ipc_magic):
    
    bpayload = json.dumps(payload).encode()
    
    message = array.array('b', ipc_magic)
    message.extend(
            struct.pack('i', len(bpayload)))
    message.extend(struct.pack('i', message_type))
    message.extend(bpayload)

    return message


def unpack_header(data): 
    return struct.unpack(fmt_header, data[:fmt_header_size])

def receive(s):
    while True:
        buf = array.array('B')
        try:
            buf.extend(s.recv(chunk_size))
            response = dict(zip(('magic','size','type'),
                                unpack_header(buf)))
            msg_size = fmt_header_size + response['size']
            while len(buf) < msg_size:
                buf.extend(s.recv(chunk_size))
            
            response['payload'] = json.loads(
                buf[fmt_header_size:].tobytes().decode('utf-8'))

            if response['type'] is 2:
                return response['payload']['success']
            else:
                return response['payload']['container']['id']

        except socket.timeout:        
            return buf




if __name__ == '__main__':
    
    #command = 'xterm'
    command = ' '.join(sys.argv[1:])
    #print (command)

    i3path = subprocess.check_output(["i3", "--get-socketpath"]).strip()

    message = i3pack (2, payload=['window'])

    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.settimeout(10)
    s.connect(i3path)
    s.sendall(message)

    status = receive(s)    
    
    subprocess.check_output(["i3-msg", 'exec', command ])
    
    cont_id = receive(s)


    if cont_id:
        condition = '[con_id='+ str(cont_id) + ']'
        cmd = ["i3-msg", condition, 'focus' ]
        subprocess.check_output(cmd)
        #print (' '.join(cmd))
        print (condition)
