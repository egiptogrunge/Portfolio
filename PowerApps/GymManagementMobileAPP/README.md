# Gym Management Mobile APP

## About

In this project I created a Canvas App, with Microsoft Power Apps, for mobile users. The objective is to improve the process of identification and registration of items needing maintenance or cleaning.
The users can login the App, and them can register if they already check all the gym rooms, and if some item needs maintanence/cleaning the user can take pictures with the App and register the issue.
All the data needed to work is stored in the Microsoft Dataverse.

## Detailed description

### Login Page
![Captura de ecrã 2024-04-18 104417](https://github.com/egiptogrunge/Portfolio/assets/161729526/dc83d888-b10f-4840-9d93-8ca9852c454a)

To Loggin into the App the user need to be registered on the Users table on Dataverse. It should have a Username and a Password. This page also allows the navigation to the password recovering page.

Here the code for the credentials check:
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
The Password is hide be default, but pressing the blue button it changes to visible, using this code on Mode property on the text input:
~~~
If(BotaoVer.Pressed; TextMode.SingleLine; TextMode.Password)
~~~
I also set the Username and Password to be reseted each time this page is visible.

At App starting I define the refresh of Users table info, and one variable to check the version of the app. I used this code:
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

### Sucesfull login page

![Captura de ecrã 2024-04-18 111017](https://github.com/egiptogrunge/Portfolio/assets/161729526/582668a9-1749-4386-9406-0a161d598574)

In this page it welcomes the user (using the varUsername creted at the login), it shows the date, and has one item to click if the user wants to change account (navigate to the login page), and one right arrow to click to navigate to home page.

### Home Page

![Captura de ecrã 2024-04-18 111530](https://github.com/egiptogrunge/Portfolio/assets/161729526/b9480af5-83c5-4392-bce3-cc62e3aec75b)

In the home page the user can select the navigation for 3 pages, the gym maintanece page, the change password page and the recover password page.

### Info about page design
The home page, and most of the pages of the App, were designed using containers (either horizontal or vertical). They have generally at least 3 containers, the header, the footer and the body.
The body has inner containers according necesity.
For the header and the footer it were created components, since they will be the same on most pages.

#### Header Component
![Captura de ecrã 2024-04-18 112220](https://github.com/egiptogrunge/Portfolio/assets/161729526/ab2c1d0a-70be-42b9-9dab-5a9c9021cfd6)

For the header component, I have a horizontal container in wich I added 3 Icons. They allow the navigation to home page, go back, and navigation to login page.
To navigation work I created 3 custom properties, of the screen type, on the component, one for each Icon. On each Icon it was added the code *componentName.customProperty()* on the OnSelect property of the butom.
The code *App.ActiveScreen* was added at each custom property. Finaly, to work on the App screen, it was added to the custom properties on the screen the code to navigate to the desired page.

Note that some pages have the 3 Icons on the header, but for security reasons not all work. For example, on the page for recover password only the X Icon (to navigate to login page) works.
This is because the user on the login page can navigate to the recover password page without make the login, meaning that if the home Icon worked the user could acess the app withou loggin.

#### Footer Component
![Captura de ecrã 2024-04-18 135418](https://github.com/egiptogrunge/Portfolio/assets/161729526/d1ea4542-7943-4b66-8943-0c0de68d774c)

The footer component just have one vertical container, in which is presented the Version of the App, using the variable "varAppVersion" created on the app start (check the code above).

### Gym management
### Rooms Page
![Captura de ecrã 2024-04-18 140042](https://github.com/egiptogrunge/Portfolio/assets/161729526/6ce844ec-8597-4123-8f8c-2c90702df2cd)

When the user click in the Gym Management button on home page, it will be redirect to this page, in which the different Rooms of the gym are presented. The user can select which Room wants to verify. The Room buttons were added as a gallery, that is feeded with a table in dataverse. That table has the gym items to verify (such as the gym machines), the room that each item belongs, and if the item needs to be photographed to considered veryfied (see bellow). To apper the rooms withou repetition I need to use the "distinct" function on the Items gallery propertie (*Distinct('GymTable'; Room*).

![Captura de ecrã 2024-04-18 140732](https://github.com/egiptogrunge/Portfolio/assets/161729526/aee59bfc-9dbb-4a67-9c90-8809bfbadff6)

When the user press the button for the desired Room, the App navigate to the Items page, and create one varible that stores the corresponding room (varRoom).

### Items Page
![Captura de ecrã 2024-04-18 141513](https://github.com/egiptogrunge/Portfolio/assets/161729526/65bf7e54-ad5b-4579-ac22-7400097db556)

On this page it is presented a gallery with the Items in the GymTable. The Items are filtered using the varRoom created on previous screen (*Filter('GymTable'; Room=varRoom)*). It was also included a Icon of a camera, only in the items which in the table are stated as needing photographs to confimr its condition verification. The Icon also lead to the navigation to the camera page to take pictures of that specific item when pressed. The color of the Icon change from blue to green when the item already has pictures salved in that day. The code used was:

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

The toogles in each item are for the user indicate that already checked the condition of that item. After a session of verifications, the user can register the verification pressing the button on the bottom. That button patch the data (the items name and room, the status of the toogle and the date) to another table on Dataverse, the table of inspections performed. Here is the code:

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




