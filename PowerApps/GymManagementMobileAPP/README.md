# Gym Management Mobile APP

## About

In this project, I developed a Canvas App using Microsoft Power Apps tailored for mobile users. The objective is to enhance the process of identifying and registering items requiring maintenance or cleaning. Users can log in to the app, check if they have already inspected all the gym rooms, and if any item needs maintenance/cleaning, they can take pictures with the app and register the issue. All the necessary data is stored in Microsoft Dataverse.

## Author
José do Egipto Ferreira Antunes, from Braga, Portugal.

## Detailed description
In this document, I will outline the main features and relevant code utilized. For more detailed information, you can access the "Documentation" subfolder within this directory.

### Login Page
![Captura de ecrã 2024-04-18 104417](https://github.com/egiptogrunge/Portfolio/assets/161729526/dc83d888-b10f-4840-9d93-8ca9852c454a)

To log in to the app, the user needs to be registered in the Users table on Dataverse, which should include a Username and a Password. This page also provides navigation to the password recovery page.

Below is the code for the credentials check:
~~~
If(LookUp(UsersInfo;Username=Username;Username)=Username.Text
&&
LookUp(UsersInfo;Username=Username;Password)=Password.Text;
Navigate(LoginSucess)
&&
Set(varUsername;Username.Text);
Reset(Username)&&Reset(Password));;
~~~

![Captura de ecrã 2024-04-18 105332](https://github.com/egiptogrunge/Portfolio/assets/161729526/bab9eac2-7893-4df8-ad42-ac3b65c23c36)

When the Username exist on the Users table it turns green, due to this code in the text color property:
~~~
If(IsBlank(Username.Text); RGBA(166; 166; 166; 1);
If(LookUp(UsersInfo; Username = Username; Username) = Username.Text;
RGBA(0; 255; 0; 1)))
~~~
The Password is hidden by default, but pressing the blue button changes it to visible using this code in the Mode property of the text input:
~~~
If(BotaoVer.Pressed; TextMode.SingleLine; TextMode.Password)
~~~
I also set the Username and Password to be reset each time this page is visible.

At the start of the app, I define the refresh of the Users table information and a variable to check the version of the app. I used this code:
~~~
Refresh(UsersInfo);;

ClearCollect(Usernames; UsersInfo);;

Set(varAppVersion; "Version "& CountRows(
    PowerAppsparaCriadores.GetAppVersions(
        First(
            Filter(
                PowerAppsparaCriadores.GetApps().value;
                properties.displayName = "AppName"
            )
        ).name
    ).value
)
& ".0.0.0");;
~~~

### Successful login page
![Captura de ecrã 2024-04-18 111017](https://github.com/egiptogrunge/Portfolio/assets/161729526/582668a9-1749-4386-9406-0a161d598574)

On this page, it welcomes the user (using the varUsername created at login), displays the date, and provides an option to change the account (navigate to the login page) and a right arrow to navigate to the home page.

### Home Page
![Captura de ecrã 2024-04-18 111530](https://github.com/egiptogrunge/Portfolio/assets/161729526/b9480af5-83c5-4392-bce3-cc62e3aec75b)

In the home page, the user can select navigation for three pages: the gym maintenance page, the change password page, and the recover password page.

### Info about page design
The home page, as well as most of the pages of the app, were designed using containers (either horizontal or vertical). Typically, they consist of at least three containers: the header, the footer, and the body. The body contains inner containers as needed. Components were created for the header and footer since they remain consistent across most pages.

#### Header Component
![Captura de ecrã 2024-04-18 112220](https://github.com/egiptogrunge/Portfolio/assets/161729526/ab2c1d0a-70be-42b9-9dab-5a9c9021cfd6)

For the header component, I created a horizontal container and added three icons. They facilitate navigation to the home page, going back, and navigating to the login page. To make navigation work, I created three custom properties of the screen type within the component, one for each icon. On each icon, I added the code *componentName.customProperty()* to the OnSelect property of the button. Additionally, I included *App.ActiveScreen* in each custom property. Finally, to enable navigation within the app, I added the corresponding code to the custom properties on the screen to navigate to the desired page.

It's important to note that some pages have all three icons in the header, but not all icons work for security reasons. For instance, on the recover password page, only the X icon (to navigate to the login page) functions. This is because users on the login page can navigate to the recover password page without logging in. If the home icon worked, users could access the app without logging in, which poses a security risk.

#### Footer Component
![Captura de ecrã 2024-04-18 135418](https://github.com/egiptogrunge/Portfolio/assets/161729526/d1ea4542-7943-4b66-8943-0c0de68d774c)

The footer component consists of a single vertical container, which presents the version of the app using the variable "varAppVersion" created at the app's start (check the code above).

### Gym management
### Rooms Page
![Captura de ecrã 2024-04-18 140042](https://github.com/egiptogrunge/Portfolio/assets/161729526/6ce844ec-8597-4123-8f8c-2c90702df2cd)

When the user clicks the Gym Management button on the home page, they are redirected to this page, where the different rooms of the gym are presented. The user can select which room they want to inspect. The room buttons are displayed as a gallery, which is fed with info from a table in Dataverse. This table contains the gym items to be inspected (such as gym machines), the room to which each item belongs, and whether the item needs to be photographed to be considered verified (see below). To display the rooms without repetition, the "Distinct" function is used in the Items gallery property (*Distinct('GymTable'; Room)*).

![Captura de ecrã 2024-04-18 140732](https://github.com/egiptogrunge/Portfolio/assets/161729526/aee59bfc-9dbb-4a67-9c90-8809bfbadff6)

When the user presses the button for the desired room, the app navigates to the Items page and creates a variable that stores the corresponding room (varRoom).

### Items Page
![Captura de ecrã 2024-04-18 141513](https://github.com/egiptogrunge/Portfolio/assets/161729526/65bf7e54-ad5b-4579-ac22-7400097db556)

On this page, a gallery is presented with the items in the GymTable. The items are filtered using the varRoom created on the previous screen (*Filter('GymTable', Room=varRoom)*). An icon of a camera is included only for items in the table that are stated as needing photographs to confirm their condition verification. The icon also leads to the navigation to the camera page to take pictures of that specific item when pressed. The color of the icon changes from blue to green when the item already has pictures saved on that day. The code used was:
~~~
//Code in OnSelect Property - For the navigation to camera page:
Navigate(Camera);;
Set(varItem; ThisItem);;

//Code in Visible Property - to appear the icon only in the desired items:
If(ThisItem.temFoto=0; true; false)

//Code in Color Property - To change Icon color if has pictures on that day:
If(IsBlank(
    LookUp(FotosSalvas;Item = ThisItem.ItemsVerificar&&Sala=varSala&&Data=Today()).Item);
    RGBA(0; 84; 148; 1);
    Color.DarkGreen)
~~~

![Captura de ecrã 2024-04-18 143457](https://github.com/egiptogrunge/Portfolio/assets/161729526/2596d5e2-fdf5-4bb6-8b5b-39056836251c)

The toggles in each item are for the user to indicate that they have already checked the condition of that item. After a session of verifications, the user can register the verification by pressing the button at the bottom. That button patches the data (the item's name and room, the status of the toggle, and the date) to another table on Dataverse, the table of inspections performed. Here is the code:
~~~
ForAll(Gallery6.AllItems;
Patch(ItemsInspecionados; 
    Defaults(ItemsInspecionados);
    {
        Sala: varItem.Local;
        Data: Today();
        Item: Title6.Text;
        EstadoToggle: Toggle1.Value
    }
    )
)
~~~ 

### Camera Page
![Captura de ecrã 2024-04-18 145049](https://github.com/egiptogrunge/Portfolio/assets/161729526/41019e9a-9294-4954-9ca9-c61f1d57f9d2)

This page allows the user to open the camera of their smartphone (or other device) and take pictures of the items for inspection. At the top of the body container, there is a square to display the camera view. In the middle, there are icons to press to take pictures, change the camera, and navigate to the gallery page. Below, it presents a snapshot of the last picture taken.

When the icon to take a picture is pressed, it also sends the picture to a collection. Here is some relevant code:
~~~
//OnSelect property of take picture Icon:
UpdateContext({varImagem: Camera1.Stream});;
Collect(Galeria; Camera1.Stream);;

//OnSelect property of change camera Icon:
If(varCamera>=CountRows(Camera1.AvailableDevices);
    UpdateContext({varCamera:0}); UpdateContext({varCamera: varCamera + 1})
);;

//OnSelect property of navigate to gallery Icon:
Navigate(GymGallery)
~~~

### Gallery Page
![Captura de ecrã 2024-04-18 150257](https://github.com/egiptogrunge/Portfolio/assets/161729526/7d729687-77bb-4e9a-9363-135c2639fa0f)

This page presents the pictures taken in that app session. It features a Gallery component, allowing scrolling left and right to view all the pictures. Users can also save or delete each picture, and when saving, they can add some observations about the item.

The picture, observations, date, room name, and item name are stored in another Dataverse table (FotosSalvas) using the Patch function:
~~~
Patch(FotosSalvas; 
    Defaults(FotosSalvas);
    {
        Sala: varItem.Local;
        Data: Today();
        Imagem: {Full: Image5.Image; Value: Image5.Image};
        Item: varItem.ItemsVerificar;
        Observacoes: txt_obs.Text
    }
)
~~~

### Recover Password Page
![Captura de ecrã 2024-04-18 151113](https://github.com/egiptogrunge/Portfolio/assets/161729526/1f0c2b97-a353-4bf8-87ca-60157c53af63)

This page is solely for recovering a user's password. It prompts the user for their username and then sends the password to the email associated with the user's account in the Dataverse table. Additionally, it provides on-screen notifications regarding the non-existence of a user or the success of the operation. Below is the code executed when the button is pressed:
~~~
If(
    IsBlank(
        LookUp(
            UsersInfo;
            Username = YourUsername.Text));
    Notify(
        "Nome de usuário não encontrado. Por favor, verifique e tente novamente.";
        NotificationType.Error
    ) && Reset(YourUsername);
    Office365Outlook.SendEmailV2(LookUp(UsersInfo; Username = YourUsername.Text; Email);
    "Recuperação de password";
    "Olá, segue a tua password do sistema de manutenção do ginásio: " & LookUp(UsersInfo; Username = YourUsername.Text; Password))
    &&
    Notify(
        "Senha enviada para: "& LookUp(UsersInfo; Username = YourUsername.Text; Email);
        NotificationType.Success
    )&&
    Navigate(Login;ScreenTransition.Fade);;);;
~~~

### Change Password
![Captura de ecrã 2024-04-18 151702](https://github.com/egiptogrunge/Portfolio/assets/161729526/e867f2cd-52fb-49a5-9f2c-a47f2970e3cb)

Finally, the app also includes a page for changing the password. It prompts the user for their username, current password, and desired new password.
When the button is pressed, the software checks if the current password matches the username. If it does, it changes the password to the new one provided. The app also provides on-screen notifications if the username or password is incorrect, as well as if the operation was successful. Below is the code inserted into the OnSelect property of the button:
~~~
If(
    IsBlank(LookUp(
        UsersInfo;
        Username = Username_reset.Text && Password = OldPassword.Text
    ));
    Notify("Nome de usuário não encontrado ou senha incorreta."; NotificationType.Error)
    &&
    Reset(Username_reset)
    &&
    Reset(NewPassword)
    ;
    UpdateIf(
    UsersInfo;
    Username = Username_reset.Text && Password = OldPassword.Text;
    {Password: NewPassword.Text})
    ;;
    Notify("Senha redefinida com sucesso."; NotificationType.Success)
    &&
    Navigate(Login; ScreenTransition.Fade)
);;
~~~

### Navigation Scheme
Here is a comprehensive overview of the navigation options available to the user within the app:

![](https://github.com/egiptogrunge/Portfolio/blob/main/PowerApps/GymManagementMobileAPP/Documentation/ScreenNavigation.png)

Navigation Options
1. Login Page: Allows users to log in to the app using their username and password. Additionally, it provides an option to navigate to the password recovery page if needed.
2. Successful Login Page: Welcomes the user upon successful login, displaying their username and the current date. It also provides options to change the account or navigate to the home page.
3. Home Page: The central hub of the app, offering navigation to three main sections: gym maintenance, change password, and password recovery.
4. Gym Management Page: Accessible from the home page, this section allows users to select and inspect different rooms within the gym, such as equipment areas or 5. workout spaces.
6. Rooms Page: Displays a list of available rooms within the gym, allowing users to choose which area they want to inspect.
7. Items Page: After selecting a room, users are directed to this page, which presents a gallery of items within that specific area. Users can toggle the status of each item to indicate if it has been inspected.
8. Camera Page: Enables users to capture photos of items during inspections. It provides options to switch between cameras, take pictures, and navigate to the gallery page.
9. Gallery Page: Presents a collection of photos taken during the inspection process. Users can scroll through images, save or delete photos, and add observations about each item.
10. Password Recovery Page: Allows users to recover their password by entering their username. Upon submission, the app sends the password to the email associated with the user's account and provides on-screen notifications for success or failure.
11. Change Password Page: Provides a form for users to change their password. Users must enter their current password, along with the new password they desire. Upon submission, the app verifies the credentials and notifies the user of success or failure.

These navigation options facilitate seamless interaction with the app, ensuring users can easily access the features they need.

## License
Anyone can use, copy, modify, merge, publish, and distribute all the software, provided that:

- The software is used for legal purposes only.
- The software is not used for commercial purposes or financial gain.
- The author is appropriately credited in any derivative works or distributions.
- The software is provided "as is," without warranty of any kind, express or implied.
