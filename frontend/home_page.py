import customtkinter
from PIL import Image
from utils import app

heading = customtkinter.CTkLabel(app, text='Share', height = 30, font=('Inter', 30, "bold"))
heading.pack(pady = 25)
sub_heading = customtkinter.CTkLabel(app, text='Share files to anybody connected on the same Wi-Fi network', height = 15, font=('Inter', 13))
sub_heading.pack(pady = 0)

send_btn_image = customtkinter.CTkImage(Image.open("assets\sendBtn.png"), size=(120, 120) ) # importing the send button 
recieve_btn_image = customtkinter.CTkImage(Image.open("assets\\recvBtn.png"), size =(120, 120) ) # importing the recieve button 

def send():
    print('You clicked the send button')

def recieve():
    print("You clicked the recieve button")

send_button = customtkinter.CTkButton(app, text='',  image = send_btn_image, command=send, fg_color="transparent",hover_color=("orange"))
send_button.pack(pady = 40)
recieve_button = customtkinter.CTkButton(app, text='', image = recieve_btn_image, command=recieve,fg_color="transparent", hover_color=("purple"))
recieve_button.pack(pady = 20)

app.mainloop()