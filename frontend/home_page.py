import customtkinter

customtkinter.set_appearance_mode("System")  # Modes: system (default), light, dark
customtkinter.set_default_color_theme("blue")  # Themes: blue (default), dark-blue, green

app = customtkinter.CTk()  # create CTk window like you do with the Tk window
app.geometry("450x520")
app.title('Laptop Share')

label_1 = customtkinter.CTkLabel(app, text='Share', height = 30, font=('Inter', 25))
label_1.pack(pady = 25)
label_2 = customtkinter.CTkLabel(app, text='Share files to anybody connected on the same Wi-Fi network', height = 15, font=('Inter', 12))
label_2.pack(pady = 0)


# TODO: MAKE PICTURE AS BUTTON 
# def button_event():
#     print("button pressed")

# button = customtkinter.CTkButton(master=app,
#                                  text="CTkButton",
#                                  command=button_event,
#                                  width=60,
#                                  height=120,
#                                  border_width=0,
#                                  corner_radius=120)
# button.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)

app.mainloop()

