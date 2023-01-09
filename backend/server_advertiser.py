import os, socket, time, json, threading, random

class ServerAdvertiser():

    socket_close = False
    server_details = {"username": os.getlogin()}

    PORT = 9999
    auth_code = str(random.randint(1000, 9999))
    dest_addr = ('255.255.255.255', PORT)
    connected_clients: set

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    
    def __init__(self) -> None:
        threading.Thread(target=self.broadcast_server).start()
        threading.Thread(target=self.authorize).start()

    def broadcast_server(self):
        while not self.socket_close:
            self.server_details["time"] = time.time()
            self.sock.sendto(json.dumps(self.server_details).encode(), self.dest_addr)
            time.sleep(1)
    
    def authorize(self):
        while not self.socket_close:
            code, addr = self.sock.recvfrom(1024)
            if code.decode() == self.auth_code:
                self.sock.sendto(self.auth_code.encode(), (addr, self.PORT))
                self.connected_clients.add(addr)
            else:
                self.sock.sendto(b"None", (addr, self.PORT))

    def close(self):
        self.socket_close = True
        self.sock.close()
