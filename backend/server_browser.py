import socket, time, json
import threading, copy


class ServerBrowser():

    known_servers = {}
    socket_close = False
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(('0.0.0.0', 9999))

    def __init__(self) -> None:
        threading.Thread(target=self.remove_dull_servers).start()
        threading.Thread(target=self.recieve_server_info).start()

    def remove_dull_servers(self):
        while not self.socket_close:
            for server in self.known_servers.copy():
                if time.time()-self.known_servers[server]["time"] > 3:
                    self.known_servers.pop(server)
            time.sleep(1)
    
    def recieve_server_info(self):
        while not self.socket_close:
            server_details, addr = self.sock.recvfrom(1024)
            server_details = json.loads(server_details.decode())
            self.known_servers[addr] = server_details
            time.sleep(0.1)
    
    def connect(self, ip: str, code:str):
        sock = copy.deepcopy(self.sock)
        sock.settimeout(5)
        sock.sendto(code.encode(), (ip, 9999))
        details, addr = sock.recvfrom(1024)
        try:
            if details == code.encode() and addr == ip:
                sock.close()
                self.close()
                return addr
            elif details == b"None":
                return "Incorrect pin"
        except socket.timeout:
            return "Could not connect to network"

    def get_servers(self):
        return self.known_servers

    def close(self):
        self.socket_close = True
        self.sock.close()
