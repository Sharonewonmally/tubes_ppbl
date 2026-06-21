import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../models/user_model.dart';
import 'buku_premium_page.dart';

class RewardPage extends StatefulWidget{
  final int userId;

  const RewardPage({super.key,required this.userId});

  @override
  State<RewardPage> createState()=>_RewardPageState();
}

class _RewardPageState extends State<RewardPage>{
  final db=DatabaseHelper();

  UserModel? currentUser;
  List<UserModel> leaderboard=[];
  bool loading=true;

  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<void> loadData()async{
    currentUser =
    await DatabaseHelper.getUser(
      widget.userId,
    );

leaderboard =
    await DatabaseHelper.getLeaderboard();

    setState(()=>loading=false);
  }

  @override
  Widget build(BuildContext context){
    if(loading){
      return const Scaffold(
        body:Center(child:CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor:const Color(0xffF8FAFC),
      appBar:AppBar(
        title:const Text("Reward"),
        centerTitle:true,
        backgroundColor:Colors.white,
        foregroundColor:Colors.black,
        elevation:0,
      ),
      body:Padding(
        padding:const EdgeInsets.all(20),
        child:LayoutBuilder(
          builder:(context,size){
            bool mobile=size.maxWidth<700;

            return Flex(
              direction:mobile?Axis.vertical:Axis.horizontal,
              children:[
                SizedBox(
                  width:mobile?double.infinity:280,
                  child:_userCard(),
                ),
                SizedBox(
                  width:mobile?0:20,
                  height:mobile?20:0,
                ),
                Expanded(
                  child:mobile
                      ?SizedBox(height:350,child:_leaderboard())
                      :_leaderboard(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _userCard(){
    final user=currentUser!;

    return Container(
      padding:const EdgeInsets.all(20),
      decoration:BoxDecoration(
        color:const Color(0xff2563EB),
        borderRadius:BorderRadius.circular(20),
        boxShadow:const[BoxShadow(color:Colors.black12,blurRadius:8)],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              CircleAvatar(
                radius:28,
                backgroundImage:user.fotoProfil.isNotEmpty
                    ?user.fotoProfil.startsWith('http')
                        ?NetworkImage(user.fotoProfil)
                        :AssetImage(user.fotoProfil) as ImageProvider
                    :null,
                child:user.fotoProfil.isEmpty
                    ?Text(
                        user.username.substring(0,2).toUpperCase(),
                        style:const TextStyle(color:Colors.white),
                      )
                    :null,
              ),
              const SizedBox(width:12),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    user.username,
                    style:const TextStyle(
                      color:Colors.white,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Bronze Member",
                    style:TextStyle(color:Colors.white70,fontSize:12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height:20),
          Container(height:1,color:Colors.white24),
          const SizedBox(height:20),
          Row(
            children:[
              Container(
                padding:const EdgeInsets.all(12),
                decoration:BoxDecoration(
                  color:Colors.white24,
                  borderRadius:BorderRadius.circular(12),
                ),
                child:const Text("⭐",style:TextStyle(fontSize:22)),
              ),
              const SizedBox(width:15),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    "${user.points}",
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:30,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "TOTAL POIN",
                    style:TextStyle(color:Colors.white70,fontSize:11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height:25),
          SizedBox(
            width:double.infinity,
            child:ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor:const Color(0xffffc96b),
                foregroundColor:Colors.brown,
              ),
              onPressed:()async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(_)=>BukuPremiumPage(userId:widget.userId),
                  ),
                );
                loadData();
              },
              child:const Text("🎁 Tukarkan poin"),
            ),
          ),
          const SizedBox(height:10),
          SizedBox(
            width:double.infinity,
            child:OutlinedButton(
              style:OutlinedButton.styleFrom(foregroundColor:Colors.white),
              onPressed:(){},
              child:const Text("📊 Detail reward"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboard(){
    return Container(
      padding:const EdgeInsets.all(20),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(20),
        boxShadow:const[BoxShadow(color:Colors.black12,blurRadius:8)],
      ),
      child:Column(
        children:[
          const Row(
            children:[
              Text("🏆",style:TextStyle(fontSize:22)),
              SizedBox(width:10),
              Text(
                "Leaderboard",
                style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height:30),
          Expanded(
            child:Row(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.end,
              children:[
                if(leaderboard.length>1)_buildRank(leaderboard[1],2),
                const SizedBox(width:30),
                if(leaderboard.isNotEmpty)_buildRank(leaderboard[0],1,big:true),
                const SizedBox(width:30),
                if(leaderboard.length>2)_buildRank(leaderboard[2],3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRank(UserModel user,int rank,{bool big=false}){
    return Column(
      children:[
        CircleAvatar(
          radius:big?40:30,
          backgroundImage:user.fotoProfil.isNotEmpty
              ?user.fotoProfil.startsWith('http')
                  ?NetworkImage(user.fotoProfil)
                  :AssetImage(user.fotoProfil) as ImageProvider
              :null,
          child:user.fotoProfil.isEmpty
              ?Text(user.username.substring(0,2).toUpperCase())
              :null,
        ),
        const SizedBox(height:10),
        Text(user.username,style:const TextStyle(fontWeight:FontWeight.bold)),
        Text("${user.points} pts",style:const TextStyle(color:Colors.grey)),
        const SizedBox(height:8),
        CircleAvatar(
          radius:14,
          backgroundColor:rank==1?Colors.amber:rank==2?Colors.grey:Colors.orange,
          child:Text("$rank",style:const TextStyle(color:Colors.white,fontSize:12)),
        ),
      ],
    );
  }
}