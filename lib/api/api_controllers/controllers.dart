import 'dart:convert';

import 'package:elector/api/api_controllers/pref_manager.dart';
import 'package:elector/screens/box_man_screen/bottom_navigation.dart';
import 'package:elector/screens/otp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiControllers {
  bool isLoading = false;
  dynamic apiUrl = "http://35.175.156.58/api";

  /*-----------------------Group Manager---------------------*/

  //Register
  Future<dynamic> Register(
      {username,
      fullname,
      idc,
      locality_id,
      password,
      phone,
      birthdate}) async {
    print(
        "username is $username fullname is $fullname and idc is $idc locatlity $locality_id password $password and phone $phone and birthdate is $birthdate");

    var mydata = {
      "locality_id": locality_id,
      "phone": "$phone",
      "username": "$username",
      "fullname": "$fullname",
      "idc": "$idc",
      "password": "$password"
    };

    var finaldata = json.encode(mydata);

    // print(" fgd ${mydata}");
    var res = await http.post(Uri.parse("$apiUrl/register"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: finaldata);
    // print("ggggggggggggg ${res.body}");
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  //Login
  Future<dynamic> Login(context, {phone, password}) async {
    var mydata = {
      "phone": '$phone',
      "password": '$password',
    };

    // print(mydata);

    var res = await http.post(Uri.parse("$apiUrl/login"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(mydata));
    // print("ggggggggggggg ${res.body}");
    print('the response is ${res.body}');
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (data['status'] == "success") {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => OTPScreen(phone: phone))));
      } else {
        return Fluttertoast.showToast(msg: 'خطأ في بيانات تسجيل الدخول');
      }
// /**********************/
//       await PrefManager().set(
//           'userdetails',
//           json.encode({
//             'id': data['data']['id'],
//             'idc': data['data']['idc'],
//             'username': data['data']['username'],
//             'fullname': data['data']['fullname'],
//             'phone': data['data']['phone'],
//             'role_id': data['data']['role_id'],
//             'locality_id': data['data']['locality_id'],
//             'accessToken': data['data']['accessToken'],
//           }));
// //*///////////////
      // if (data['data']['role_id'] == '4') {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: ((context) => const BottomNavigatorCashier())));
      // } else {
      //   Navigator.pushReplacementNamed(context, '/bottom_navigator_screen');
      // }
      // print(data);
      return data;
    } else {
      return Fluttertoast.showToast(msg: 'خطأ في بيانات تسجيل الدخول');
    }
  }

  //verifyOTP
  Future<dynamic> verifyOTP(context, {phone, otp}) async {
    print("$apiUrl/verify_otp");

    var mydata = {
      "phone": '$phone',
      "otp": otp,
    };

    // print(mydata);

    var res = await http.post(
      Uri.parse("$apiUrl/verify_otp"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(mydata),
    );
    // print("ggggggggggggg ${res.body}");
    print('the response is ${res.body}');
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: ((context) => const OTPScreen())));
      if (data['status'] == "success") {
        await PrefManager().set(
            'userdetails',
            json.encode({
              'id': data['data']['user']['id'],
              'idc': data['data']['user']['idc'],
              'username': data['data']['user']['username'],
              'fullname': data['data']['user']['fullname'],
              'phone': data['data']['user']['phone'],
              'role_id': data['data']['user']['role_id'],
              'locality_id': data['data']['user']['locality_id'],
              'accessToken': data['data']['access_token'],
            }));

        // if (await FlutterContacts.requestPermission()) {
        //   // Get all contacts (lightly fetched)
        //   List<Contact> contacts;
        //   contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
        //   List listofcontacts = [];
        //   for (int i = 0; i < contacts.length; i++) {
        //     try {
        //       listofcontacts.add(
        //         {"user_id": data['data']['user']['id'], "name": contacts[i].displayName, "phone": contacts[i].phones[0].number},
        //       );
        //
        //       storecontacts(name: listofcontacts);
        //
        //       Fluttertoast.showToast(
        //         msg: "Contact has been send",
        //       );
        //     } catch (e) {}
        //   }
        // }
        // print(listofcontacts);

        // await storecontacts(name:listofcontacts );

        // print("my role is ${data['data']['user']['role_id']}");
        // print("my role is ${data['data']['user']['fullname']}");
        PrefManager().setName(data['data']['user']['fullname']);

        if (data['data']['user']['role_id'] == '4') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => const BottomNavigatorCashier()),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/bottom_navigator_screen');
        }
      } else {
        print(data);
      }
      return data;
    } else {
      return Fluttertoast.showToast(msg: 'خطأ في الكود المدخل');
    }
  }

  //Logout
  Future<bool> logout() async {
    var res = await http.get(Uri.parse("$apiUrl/logout"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        });

    if (res.statusCode == 200) {
      // SharedPrefController().clear();
      return true;
    }
    return false;
  }

  //Contact Us
  Future<dynamic> ContactUs({email, message}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {
      "email_or_phone": '$email',
      "message": '$message',
    };

    var res = await http.post(Uri.parse("$apiUrl/connect_us/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      // print(data);
      return data;
    } else {
      return data;
    }
  }

  // Get Video
  Future<dynamic> getVideo() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im video");

    var res = await http.get(
      Uri.parse("$apiUrl/video"),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    final data = await json.decode(res.body);
    print(data);
    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  // Get Video
  Future<dynamic> getSetting() async {
    // var details = await json.decode(await PrefManager().get('userdetails', {}));
    // print("im followers ${details['accessToken']}");
    // print("im video");

    var res = await http.get(
      Uri.parse("$apiUrl/election"),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    final data = await json.decode(res.body);
    print(data);
    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);
      return data;
    } else {
      return "error";
    }
  }

  // Get getboxvoters
  Future<dynamic> getBoxVoters() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im box/voters");

    var res = await http.get(
      Uri.parse("$apiUrl/box/voters"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    final data = await json.decode(res.body);
    // if (kDebugMode) {
    //   print(data);
    // }

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data['data']);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      print(data);
      Fluttertoast.showToast(msg: data['data']);
      return data;
      // return "error";

    }
  }

  // Get supports
  Future<dynamic> getsupports() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im getsupports");

    var res = await http.get(
      Uri.parse("$apiUrl/supporters"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

//get activists
  Future<dynamic> getactivists() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im getactivists");

    var res = await http.get(
      Uri.parse("$apiUrl/activists"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  ///get followers
  Future<dynamic> getfollowers() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");

    var res = await http.get(
      Uri.parse("$apiUrl/followers"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);
      return data;
    } else {
      return "error";
    }
  }

  ///get contacts
  Future<dynamic> getcontacts(String route) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    if (kDebugMode) {
      print("im followers ${details['accessToken']}");
      // print("im followers ff ${details['data']['user']['username']}");
    }

    print("$apiUrl/${route}");

    var res = await http.get(
      Uri.parse("$apiUrl/${route}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print("gggggggggggg");
      final data = await json.decode(res.body);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return "error";
    }
  }

  Future<dynamic> searchContacts(Map key) async {
    print(key);
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    if (kDebugMode) {
      print("im followers ${details['accessToken']}");
      // print("im followers ff ${details['data']['user']['username']}");
    }

    var res = await http.post(Uri.parse("$apiUrl/voters/searchContacts"),
        headers: <String, String>{
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: key);
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print("gg");
      final data = await json.decode(res.body);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return "error";
    }
  }

  Future<dynamic> searchNonContacts(Map key, int page) async {
    print(key);
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    if (kDebugMode) {
      print("im followers ${details['accessToken']}");
      // print("im followers ff ${details['data']['user']['username']}");
    }

    var res = await http.post(Uri.parse("$apiUrl/voters/search?page=${page}"),
        headers: <String, String>{
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: key);
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print("gggggggggggg");
      final data = await json.decode(res.body);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return "error";
    }
  }

  Future<dynamic> addactivitists(context, {voters_id}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {
      "voters_id": '$voters_id',
    };

    var res = await http.post(Uri.parse("$apiUrl/followers/add_activists"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      Fluttertoast.showToast(msg: data['status']);
      Navigator.pop(context);
      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return data;
    }
  }

  ///add_activitist
  ///
  Future<dynamic> addfollowers({voters_id}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {
      "voters_id": '$voters_id',
    };

    var res = await http.post(Uri.parse("$apiUrl/contacts/add_follower"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "added successfully");
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  //get groups

  Future<dynamic> getagroups() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im getgroups");

    var res = await http.get(
      Uri.parse("$apiUrl/groups"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

//store_contacts
  Future<dynamic> storecontacts({userid, name, phone}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {"data": name};

    var res = await http.post(Uri.parse("$apiUrl/contacts/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  //get videos

  Future<dynamic> getvideos() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im getvideos");

    var res = await http.get(
      Uri.parse("$apiUrl/video"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      return "error";
    }
  }

/*--------------------------Cashier------------------------*/
//Add Voters
  Future<dynamic> updategroupname({groupid, groupname}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {
      "name": '$groupname',
    };

    var res = await http.post(Uri.parse("$apiUrl/groups/update/$groupid"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    print(res.body);

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  ///create_group

  Future<dynamic> creategroup({groupname}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    var mydata = {
      "name": '$groupname',
    };

    var res = await http.post(Uri.parse("$apiUrl/groups/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

//deletegroup
  Future<dynamic> deletegroup({groupid, groupname}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    // var mydata = {
    //   "name": '$groupname',
    // };

    var res = await http.delete(
      Uri.parse("$apiUrl/groups/destroy/$groupid"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  //delete follower from group
  Future<dynamic> deleteFollower({groupid, groupname}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");

    var res = await http.delete(
      Uri.parse("$apiUrl/groups/destroy/$groupid"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  //delete follower
  Future<dynamic> ddeelleetteeFollower({followerId}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));

    var mydata = {
      "voters_id": '$followerId',
    };
    print("im followers $mydata");
    print("$apiUrl/contacts/delete_follower");

    var res = await http.post(Uri.parse("$apiUrl/contacts/delete_follower"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

//Add Voters
  Future<dynamic> addVoter({number}) async {
    var mydata = {
      "key": '$number',
    };

    var res = await http.post(Uri.parse("$apiUrl/voters/update"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
        },
        body: mydata);
    print("ggggggggggggg ${res}");

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print(data);
      Fluttertoast.showToast(msg: data['status']);
      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return data;
    }
  }

//search by phone no

  Future<dynamic> searchfollower(input) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    if (kDebugMode) {
      print("im followers ${details['accessToken']}");
    }
    var mydata = {
      "key": '$input',
    };

    var res = await http.post(Uri.parse("$apiUrl/followers/search"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  ///add support to group
  ///

  Future<dynamic> addsupporttogroup({group_id, supporters_id}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    // print("im followers ${details['accessToken']}");
    var mydata = {"group_id": '$group_id', 'supporters_id': "$supporters_id"};

    var res = await http.post(Uri.parse("$apiUrl/user_groups/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  ///show_support_inside_group
  ///

  Future<dynamic> showsupportinsidegroup(groupid) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    // print("im followers ${details['accessToken']}");
    // print("im getvideos");

    var res = await http.get(
      Uri.parse("$apiUrl/user_groups/$groupid"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    if (kDebugMode) {
      print(res.body);
    }
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      if (kDebugMode) {
        print(data);
      }

      return data;
    } else {
      return "error";
    }
  }

  //delete supporter
  Future<dynamic> deletesupportfromgroup({supportid}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
//print("im followers ${details['accessToken']}");
    // var mydata = {
    //   "name": '$groupname',
    // };
    print("$apiUrl/user_groups/destroy/$supportid");
    var res = await http.delete(
      Uri.parse("$apiUrl/user_groups/destroy/$supportid"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      return data;
    }
  }

  // add_elector

  Future<dynamic> addelector({voters_id, bool remove = false}) async {
    print(voters_id);
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("$apiUrl${remove ? "/voters/cancelVoting" : "/box/voters/update"}");
    var mydata = {
      "key": '$voters_id',
    };
    print(voters_id);

    var res = await http.post(
        Uri.parse(
            "$apiUrl${remove ? "/voters/cancelVoting" : "/box/voters/update"}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));

    if (kDebugMode) {
      print(res.body);
    }

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return data;
    }
  }

  //SendBoxVotingNumbers
  Future<dynamic> sendBoxVoteNumber({sounds1, sounds2, sounds3}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im sendBoxVoteNumber ${details['accessToken']}");
    var mydata = {
      "sounds1": '$sounds1',
      "sounds2": '$sounds2',
      "sounds3": '$sounds3',
    };

    var res = await http.post(Uri.parse("$apiUrl/box/sound/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));
    print(res.body);

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      // print(data);
      return data;
    } else {
      return data;
    }
  }

  // Add voters Manually

  Future<dynamic> addVoterManually(
      {firstName, secondName, lastName, phone, id, voterNumber, boxId}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im sendBoxVoteNumber ${details['accessToken']}");
    var mydata = {
      "first_name": '$firstName',
      "second_name": '$secondName',
      "last_name": '$lastName',
      "phone": '$phone',
      "idc": '$id',
      "voter_number": '$voterNumber',
      "box_id": '$boxId',
    };

    var res = await http.post(Uri.parse("$apiUrl/voters/store"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));
    print(res.body);

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      // print(data);
      return data;
    } else {
      Fluttertoast.showToast(msg: data['data']);
      return data;
    }
  }

  //GetBoxVotingNumbers
  Future<dynamic> getBoxVoteNumber() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im followers ${details['accessToken']}");
    print("im getgroups");

    var res = await http.get(
      Uri.parse("$apiUrl/box/sound/index"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  //GetBoxId
  Future<dynamic> getBoxNumber() async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im box ${details['accessToken']}");

    var res = await http.get(
      Uri.parse("$apiUrl/box"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${details['accessToken']}',
      },
    );
    print(res.body);
    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  //update follower phone
  Future<dynamic> updateFollowerPhone({id, phone}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im update follower phone ${details['accessToken']}");
    var mydata = {
      "phone": '$phone',
      "voters_id": id,
    };

    var res = await http.post(Uri.parse("$apiUrl/followers/update"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        },
        body: json.encode(mydata));
    print(res.body);

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      // print(data);
      return data;
    } else {
      Fluttertoast.showToast(msg: data['status']);
      return data;
    }
  }


  Future<dynamic> followersHaveBeenContacted({id}) async {
    var details = await json.decode(await PrefManager().get('userdetails', {}));
    print("im update follower phone ${details['accessToken']}");


    var res = await http.post(Uri.parse("$apiUrl/followersMarked/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${details['accessToken']}',
        });
    print(res.body);

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: data['status']);
      print(data);
      return data;
    } else {
      Fluttertoast.showToast(msg: data['status']);
      return data;
    }
  }
}
