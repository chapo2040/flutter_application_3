import 'package:flutter/material.dart';
import 'package:flutter_application_3/user.dart';
import 'package:flutter_application_3/user_api.dart';

class Home extends StatefulWidget 
{
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> 
{
  late List<user> users = [];
  bool isLoaded = false;
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
    cargaDatos();
    debugPrint("MyWidget initState called: $_counter");
  }

  void cargaDatos() async 
  {  
    debugPrint("cargaDatos...");
    users = await fetchUsers();
    setState(() {  isLoaded = true;  });
  }   

  @override
  void dispose() 
  {    
    debugPrint("MyWidget dispose called: $_counter");
    _incrementCounter();
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

  Future<void> addElement() async 
  {
    debugPrint("addElement +");    
    //Navigator.pop(context);
    //Navigator.pushNamed(context, '/add'); 
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
            
            //getUsers(),             // *rest api user from internet            
            getForm(),                // -add user to list and refresh GUI            
                                      // -add test.dart scene for test menu for: UNITS TEST
                                      // -conect to firebase
                                      // -upload proyect to GIT


      floatingActionButton: FloatingActionButton(
        onPressed: addElement,
        backgroundColor: Colors.indigo,        
        child: const Icon(Icons.add, color: Colors.white),
      ),

      bottomNavigationBar: barMenu(context) 
    );     
  }

  Widget getUsers()
  {
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

  }

  Widget getForm()
  {
    return Column
    ( 
      children: <Widget>
      [
        TextField( decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'Username', hintText: 'username', prefixIcon: Icon(Icons.person),),),        
        TextField( decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'email', hintText: 'email', prefixIcon: Icon(Icons.email),),),        
        const Divider(height: 20, thickness: 1, indent: 10, endIndent: 10, color: Colors.indigo),        
        ElevatedButton(onPressed: onPressed, child: const Text('Enviar')),
      ]                                         
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