import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/user.dart';
//import 'package:flutter_application_3/user_api.dart';
import 'package:flutter_application_3/user_firabase.dart';

class Home extends StatefulWidget 
{
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> 
{
  final _formKey = GlobalKey<FormState>();
  final txtID = TextEditingController();
  final txtName = TextEditingController();
  final txtEmail = TextEditingController();

  late List<user> users = [];
  late Stream<QuerySnapshot> snapshots;

  bool isLoaded = false;
  bool _isPressed = false;
  int _counter = 0;

  List<user> items = 
  [
    user(id: 1, name: 'Luis', email: "luis34@gmail"),
    user(id: 2, name: 'Maria', email: "maria34@gmail"),
    user(id: 3, name: 'Jose', email: "jose@gmail"),
    user(id: 4, name: 'Ruben', email: "ruben@gmail"),
  ];

  @override
  void initState() 
  {
    super.initState(); 
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    //cargaDatos();
    debugPrint("MyWidget initState called: $_counter");
  }

  void cargaDatos() async 
  {  
    debugPrint("cargaDatos...");
    //users = await fetchUsers();
    snapshots = await getUsersFireBase();    
    setState(() {  isLoaded = true;  });
  }   

  @override
  void dispose() 
  {    
    debugPrint("MyWidget dispose called: $_counter");
    _incrementCounter();
    txtID.dispose();
    txtName.dispose();
    txtEmail.dispose();
    super.dispose(); 
  }

  void _incrementCounter() 
  {
    setState((){ _counter++; });
  }

  void onItemTapped(int index) 
  {
    debugPrint("pagina: $index");
    //Navigator.pop(context);
    if(index == 0){ Navigator.pushNamed(context, '/second'); }
    if(index == 1){ Navigator.pushNamed(context, '/second'); }
    if(index == 2){ Navigator.pushNamed(context, '/second'); }
  }

  Future<void> onPressed() async 
  {
    debugPrint("onPressed");    
    Navigator.pushNamed(context, "/second");
  }

  Future<void> onCheked(int index, bool? status) async 
  {
    debugPrint("onCheked | label: ${items[index].name} - index: $index - status $status ");    
    items[index].isChecked = status!;
  }    

  Future<void> btnAddUser() async 
  {
    debugPrint("btnAddUser");    
    await addUserFireBase(txtID.text, txtName.text, txtEmail.text);    
  }  

  Future<void> btnUpdateUser() async 
  {
    debugPrint("btnUpdateUser");    
    await updateUserFireBase(txtID.text, txtName.text, txtEmail.text); 
  }  

  Future<void> btnDeleteUser() async 
  {
    debugPrint("btnDeleteUser");    
    await deleteUserFireBase(txtID.text);
  }  

  Future<void> btnGettUser() async 
  {
    debugPrint("btnGettUsers");
    
    DocumentSnapshot? doc = await getUserFireBase(txtID.text);     
    if(doc?.exists == true)
    {
      Map<String, dynamic> data = doc?.data() as Map<String, dynamic>;      
      txtName.text = data['name'];
      txtEmail.text = data['email'];
    }
    else
    {
      txtName.text = "";
      txtEmail.text = "";
    }
  }

  Future<void> btnGettUsers() async 
  {
    debugPrint("btnGettUsers");
    await printUsersFireBase(); 
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
     
      appBar: AppBar
      (         
        automaticallyImplyLeading: true,             
        leading: IconButton( onPressed: () {}, icon: Icon(Icons.computer)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text("Test"),  
      ),

      body: //Center(child: Text("¡ Hello World !")),
            //getColumns(context),
            //getRows(context),            
            //child: generateTable(4,3),  

            //getButtons(context),
            //getCombos(),
            //getListTitles(),
            
            //getUsers(),             // * rest api user from internet  
            //getAnimations(),        // * animations  
            getForm(),                // * conect to firebase: add, update & delete user
                                      // * add user to list and refresh GUI            
                                      // * add test.dart scene for test menu for: UNITS TEST                                      
                                      // * upload proyect to GIT
                                      
      
      floatingActionButton: FloatingActionButton(
        onPressed: btnGettUsers,
        backgroundColor: Colors.indigo,        
        child: const Icon(Icons.add, color: Colors.white),
      ),      

      bottomNavigationBar: barMenu(context) 
    );     
  }
  
  Widget getForm()
  {
    return Form
    (
      key: _formKey,
      child: Column
      ( 
        children: <Widget>
        [
          TextField(controller: txtID, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'id', hintText: 'id', prefixIcon: Icon(Icons.perm_identity),),),
          TextField(controller: txtName, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'Username', hintText: 'username', prefixIcon: Icon(Icons.person),),),
          TextField(controller: txtEmail, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'email', hintText: 'email', prefixIcon: Icon(Icons.email),),), 
          const Divider(height: 20, thickness: 1, indent: 10, endIndent: 10, color: Colors.indigo),        
          Row(children: 
          [
            ElevatedButton(onPressed: btnAddUser, child: const Text('Add')),
            ElevatedButton(onPressed: btnUpdateUser, child: const Text('Update')),
            ElevatedButton(onPressed: btnDeleteUser, child: const Text('Delete')),
            ElevatedButton(onPressed: btnGettUser, child: const Text('Find')),
          ]),
        ]          
      )                               
    );
  }  

  Widget getUsers()
  {    
    return isLoaded ? StreamBuilder<QuerySnapshot>
    (    
      stream: snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) 
      {
        if (snapshot.hasError) 
        {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) 
        {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasData) 
        {
          return ListView.builder
          (
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) 
            {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              return Card
              (
                margin: EdgeInsets.all(8.0),
                child: ListTile
                (
                  title: Text(data['name'] ?? 'No Name'), 
                  subtitle: Text(data['email'] ?? 'No Description'),                  
                ),
              );
            },
          );
        }
        
        return Center(child: Text('No data found.'));
      },
    )
     : const Center(child: CircularProgressIndicator()); 
  

    /*
    return isLoaded ? ListView.builder
    (
      itemCount: users.length,
      itemBuilder: (context, index) 
      {
        return ListTile
        (
          title: Text(users[index].name),
          subtitle: Text(users[index].email),
          tileColor: Colors.white          
        );
      },    
    )
    : const Center(child: CircularProgressIndicator());

    */
  }

  Widget getAnimations()
  {
    return Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _isPressed ? 150 : 100,
            height: _isPressed ? 60 : 50,
            decoration: BoxDecoration(
              color: _isPressed ? Colors.green : Colors.blueAccent,
              borderRadius: BorderRadius.circular(_isPressed ? 15 : 8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: _isPressed ? 10 : 5,
                  offset: Offset(_isPressed ? 5 : 2, _isPressed ? 5 : 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              _isPressed ? 'Enviado' : 'Enviar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),      
    );
  }

  Widget getButtons(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(onPressed: onPressed, child: const Text('Elevated')),
          FilledButton(onPressed: onPressed, child: const Text('Filled')),
          FilledButton.tonal(onPressed: onPressed, child: const Text('Filled Tonal')),
          OutlinedButton(onPressed: onPressed, child: const Text('Outlined')),
          TextButton(onPressed: onPressed, child: const Text('Text')),
        ],
      ),
    );  
  }

  Widget getCombos()
  {
    return ListView.builder
    (
      itemCount: items.length,
      itemBuilder: (context, index) 
      {
        return CheckboxListTile
        (
          title: Text(items[index].name),
          subtitle: Text(items[index].email),
          value: items[index].isChecked,
          onChanged: (bool? newValue){ setState((){  onCheked(index, newValue); }); },
        );
      },
    );
  }

  Widget getListTitles()
  {
    return ColoredBox
    (
      color: Colors.green,
      child: Material
      (
        child: Column( // Use a Column for vertical arrangement
          children: <Widget>
          [
            ListTile(title: Text('ListTile 1'), subtitle: const Text('Tap here to go back'), tileColor: Colors.white),
            const Divider(height: 20, thickness: 1, indent: 10, endIndent: 10, color: Colors.indigo),
            ListTile(title: Text('ListTile 2'), subtitle: const Text('Tap here to go back'), tileColor: Colors.white),
          ]                              
        ),
      ),
    );
  }

  Widget getColumns(BuildContext context)
  {
    final Size windowSize = getWindowSize(context);
    debugPrint("windowSize: ${windowSize.width}");

    return Column( // Use a Column for vertical arrangement
      children: <Widget>[

        SizedBox(height: 20), 
        
        Container(
          // First component (widget)
          color: Colors.blue,
          height: 100,
          width: double.infinity,
          child: Center(child: Text("Windows Size: ${windowSize.width}")),
        ),
        SizedBox(height: 20), // Add spacing between components
        Container(
          // Second component (widget)
          color: Colors.green,
          //height: 100,
          width: double.infinity,
          child: Center(child:  generateTable(4,3)),
        ),
      ],
    );
  }

  Widget getRows(BuildContext context)
  {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Aligns children along the main axis (horizontal)
            crossAxisAlignment: CrossAxisAlignment.center, // Aligns children along the cross axis (vertical)
            children: <Widget>[
          
              Container(
                color: Colors.red, width: 100, height: 50,
                child: const Center(child: Text('Widget 1')),
              ),
              Container(
                color: Colors.green, width: 100, height: 50,
                child: const Center(child: Text('Widget 2')),
              ),
              Container(
                color: Colors.blue, width: 100, height: 50,
                child: const Center(child: Text('Widget 3')),
              ),
            ],
        )
    );
  }

  Size getWindowSize(BuildContext context)
  {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size;
  }

  Widget generateTable(int row, int col)
  {
    List<TableRow> tableRows = [];

    int count = 1;
    for(int i = 0; i < row; i++)
    {
      List<Widget> rowChildren = [];
      for(int j = 0; j < col; j++)
      {
        rowChildren.add(
          Container(
            padding: EdgeInsets.all(8),
            child: Text(count.toString(), style: TextStyle(fontSize: 16)),
          )
        );
        
        count ++;
      }

      tableRows.add(TableRow(children: rowChildren));
    }

    return Table(
      border: TableBorder.all(),
      children: tableRows,
    );
  }

  Widget barMenu(BuildContext context) 
  {    
    return BottomNavigationBar(

        backgroundColor: Colors.indigo,
        unselectedItemColor: Colors.white,

        selectedFontSize: 13,
        selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 26),
        selectedItemColor: Colors.amberAccent,
        //selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        
        onTap: onItemTapped,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Orders',
            //onTap: ;
            //onTap: () { Navigator.pop(context); }
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.label),
            label: 'Config',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Other',
          ),
        ],
    );
  }
}