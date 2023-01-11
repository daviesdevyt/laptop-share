from tkinter import PhotoImage, Button
import customtkinter
from PIL import Image, ImageTk

customtkinter.set_appearance_mode("System")  # Modes: system (default), light, dark
customtkinter.set_default_color_theme("blue")  # Themes: blue (default), dark-blue, green

app = customtkinter.CTk()  # create CTk window like you do with the Tk window
app.geometry("450x520")
app.title('Laptop Share')

label_1 = customtkinter.CTkLabel(app, text='Share', height = 30, font=('Inter', 25))
label_1.pack(pady = 25)
label_2 = customtkinter.CTkLabel(app, text='Share files to anybody connected on the same Wi-Fi network', height = 15, font=('Inter', 12))
label_2.pack(pady = 0)




send_btn_image = customtkinter.CTkImage(Image.open("assets\sendBtn.png"), size=(120, 120) ) # importing the send button 
recieve_btn_image = customtkinter.CTkImage(Image.open("assets\\recvBtn.png"), size =(120, 120) ) # importing the recieve button 

# command for the buttons; will be editted later
def send():
    print('You clicked the send button')

def recieve():
    print("You clicked the recieve button")


send_button = customtkinter.CTkButton(app, text='',  image = send_btn_image, command=send, fg_color="transparent",hover_color=("orange"))
send_button.pack(pady = 40)
recieve_button = customtkinter.CTkButton(app, text='', image = recieve_btn_image, command=recieve,fg_color="transparent", hover_color=("purple"))
recieve_button.pack(pady = 20)



app.mainloop()

