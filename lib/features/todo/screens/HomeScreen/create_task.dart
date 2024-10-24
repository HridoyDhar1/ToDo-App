// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/common/wigets/snackbar/snack_bar.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/data/services/network_call.dart';

import '../../../../utils/url/urls.dart';

class CreateTask extends StatefulWidget {

 CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
      final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
    final TextEditingController _titleController=TextEditingController();
    final TextEditingController _descriptionController=TextEditingController();

      bool _addNewTaskProgress=false;
      bool _shouldRefresh=false;

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (diPop,result){
if(diPop){
  return;
}
Navigator.pop(context,_shouldRefresh);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    "New Task",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String?value){
              if(value?.isEmpty??true){
             return 'Enter a value';
              }return null;
            },
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon:const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (String?value){
              if(value!.trim().isEmpty??true){
             return 'Enter a value';
              }return null;
            },
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.description)),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: !_addNewTaskProgress,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: CustomElevatedbutton(
                            hSize: 70,
                            vSize: 15,
                            onPressed:_saveTaskButton,
                            name: "Save",
                            textColor: Colors.white),
                      ),
                   
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.white,
                              padding:const EdgeInsets.symmetric(
                                
                                  horizontal: 70, vertical: 15),),
                          child:const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveTaskButton(){
    if(_formKey.currentState?.validate()??false){
_addNewTask();
    }
  }

  Future<void>_addNewTask()async {
    _addNewTaskProgress=true;
    setState(()  {

    });
          Map<String,dynamic>requestBody={
        'title':_titleController.text.trim(),
        'description':_descriptionController.text.trim()
      };
      final NetworkResponse response=await NetworkCall.postRequest(url: Urls.addNewTask,body: requestBody);
      _addNewTaskProgress=false;
      setState(() {
        
      });
      if(response.isSuccess){
        _shouldRefresh=true;
        _clearTextFields();
        showSnackBarMessage(context, 'New Task Added');
      }else{
        showSnackBarMessage(context, response.errorMessage,true);
      }
    

  }
  void _clearTextFields(){
    _titleController.clear();
    _descriptionController.clear();
  }
  @override  
  void dispose(){
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
