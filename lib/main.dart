import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

class BlockHuntermenu extends StatefulWidget {
  const BlockHuntermenu({super.key});

  @override
  State<BlockHuntermenu> createState() => _BlockHuntermenuState();
}

class _BlockHuntermenuState extends State<BlockHuntermenu> {
  @override
  Widget build(BuildContextcontext) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("色塊獵人",style: TextStyle(color: Colors.deepPurple,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 36.0,),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ChooseLevel())),
                child:Text('火眼金睛',style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10.0,),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Color_memory_pick())),
                child:Text('迅雷不及',style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),)),
          ],
        ),
    );
  }
}

class Color_memory_pick extends StatelessWidget {
  const Color_memory_pick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("請按下有顏色的方塊!",style: TextStyle(color: Colors.deepPurple,fontSize: 25,fontWeight: FontWeight.bold),),
          Text("方塊將會隨機給取顏色",style: TextStyle(color: Colors.deepPurple,fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          ElevatedButton(
              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Color_memory_pick_Start())),
              child: Text("開始遊戲"),),
          SizedBox(height:3.0),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),),
            onPressed:()=> Navigator.of(context).pop(),
            child: Text("選擇其他小遊戲",
              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class Color_memory_pick_Start extends StatefulWidget {
  const  Color_memory_pick_Start({super.key});

  @override
  State<Color_memory_pick_Start> createState() =>  Color_memory_pick_Start_State();
}

class Color_memory_pick_Start_State extends State<Color_memory_pick_Start> {
  Color color_ordered=Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  int _pick = 0;
  int _bad = 0;
  int rc = 6;
  int time=60;
  Timer? timer;
  @override
  void initState(){
    super.initState();
    StartTimer();
  }

  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(time>0) {
        setState(() {
          time--;
        });
      }
      else{
        timer.cancel();
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>end_Color_memory(time: time,good: _pick,bad: _bad,)));
      }
    });
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int pick_block1=math.Random().nextInt(rc);
    int pick_block2=math.Random().nextInt(rc);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('剩下$time秒',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          Text('Good: $_pick',style: TextStyle(color: Colors.black,fontSize: 15),),
          SizedBox(height: 6.0,),
          Text('bad: $_bad',style: TextStyle(color: Colors.black,fontSize: 15),),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(rc,(index1){
              return Column(
                children:
                List.generate(rc,(index2){
                  if(pick_block1 == index1 && pick_block2 == index2) {
                    return Visibility(
                      visible: true,
                      child:ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            color_ordered),),
                      onPressed: () {
                        setState(() {
                          _pick++;
                        });
                      },
                      child: Text(''),
                    ),);
                  }
                  else{
                    return Visibility(
                      visible: true,
                      child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.white),),
                          onPressed: (){
                              setState(() {
                                _bad++;
                              });
                          },
                          child: Text('')), );
                  }
                }
                ),
              );
            },
            ),),
          SizedBox(height: 6.0,),
          ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("放棄此次遊戲")),
        ],
          ),
      );
  }
}

class end_Color_memory extends StatelessWidget {
  end_Color_memory({required this.time,required this.good,required this.bad,super.key});
  final int time;
  final int good;
  final int bad;

  double counter_time=0.0 ;

  double counter_con(int counter_yes,int time){
    counter_time = counter_yes / time;
    return counter_time;
  }

  @override
  Widget build(BuildContext context) {
    counter_time = counter_con(good,60);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('你總共成功點擊了$good次',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 8.0,),
          Text('你總共錯誤點擊了$bad次',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          Text('你每秒的反應速度是$counter_time秒',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
              onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const BlockHuntermenu())),
              child: Text("回到主頁",
                  style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
        ],
    ),
    );
  }
}




class ChooseLevel extends StatefulWidget {
  const ChooseLevel({super.key});

  @override
  State<ChooseLevel> createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Text("請選擇難度",style: TextStyle(color: Colors.deepPurple,fontSize: 25,fontWeight: FontWeight.bold),),
        SizedBox(height: 16.0,),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PickColorgame(level: 0,)));},
          child:Text("簡單",
            style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 6.0,),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PickColorgame(level: 1,)));},
          child:Text("普通",
            style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 6.0,),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen),),
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PickColorgame(level: 2,)));},
          child: Text("困難",
            style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: 6.0,),
         ElevatedButton(
           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),),
           onPressed:()=> Navigator.of(context).pop(),
           child: Text("選擇其他小遊戲",
             style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
           ),
         ),
      ],
      ),
    );

  }
}

class PickColorgame extends StatelessWidget {
  const PickColorgame({required this.level,super.key});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(
        children: [
          Text("請尋找指定顏色的色塊!",style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0,),
          _PickColorgame(level: level,),
      ],
      ),
    );
  }
}

class _PickColorgame extends StatelessWidget {
  const _PickColorgame({required this.level ,super.key});

  final int level;
  int row_and_column_pick(int _level){
    int rc=0;
    if(_level==1){
      rc=4;
    }
    else if(_level==2){
      rc=6;
    }
    else{
      rc=3;
    }
    return rc;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Blockpick(level: level, rc: row_and_column_pick(level)),
          SizedBox(height:3.0),
          ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("放棄此次遊戲"))
        ],
      ),
    );
  }
}

class Blockpick extends StatefulWidget {
  const Blockpick({required this.level, required this.rc, super.key});

  final int level;
  final int rc;
  @override
  State<Blockpick> createState() => _BlockpickState(level: level,rc:rc);
}

class _BlockpickState extends State<Blockpick> {
  _BlockpickState({required this.level,required this.rc});
  final int level;
  final int rc;
  int time=0;
  int _counter = 0;
  int _pick = 3;
  int _yes = 0;
  double time_counter = 0.0;
  Timer? timer;
  Color color_ordered=Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  double counter_con(int counter_yes,int time){
    time_counter = counter_yes / time;
    return time_counter;
  }

  @override
  void initState(){
   super.initState();
   StartTimer();
  }
  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time++;
      });
      if(_pick<=0){
        timer.cancel();
      }
    });
  }


  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    int pick_block1=math.Random().nextInt(rc);git
    int pick_block2=math.Random().nextInt(rc);

    Color color(int i,int j){
      if (pick_block1==i && pick_block2==j){
        return color_ordered;
      }
      else{
        return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      }
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text('請選擇與右方相同的顏色',style:
                TextStyle(color: Colors.deepPurple,fontSize: 15,fontWeight: FontWeight.bold),),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        color_ordered),),
                  onPressed: () {},
                  child: Text(''),
                )
              ]
          ),
          Text('已累積選擇數量: $_counter',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Text('還剩餘 $_pick 次的容錯機會',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Text('已選對$_yes次',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Text('已花費$time秒',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:List.generate(rc,(index1){
              return Column(
                children:
                List.generate(rc,(index2){
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          color(index1,index2)),),
                    onPressed: () {
                      setState(() {
                        _counter++;
                        if(color(index1,index2)!=color_ordered)
                        {_pick--;
                        if(_pick<=0){
                          time_counter = counter_con(_yes, time);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>settle_up(counter_yes: _yes,counter: _counter,time:time_counter,)));
                        }}
                        else{
                          _yes++;
                        }
                        color_ordered=Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
                      }
                      );
                    },
                    child: Text(''),
                  );
                }
                ),
              );
            },
            ),),
        ],
      ),
    );
  }
}

class settle_up extends StatelessWidget {
  settle_up({required this.counter_yes,required this.counter,required this.time,super.key});
  final int counter_yes;
  final int counter;
  final double time;

  @override
  Widget build(BuildContext context) {
    return Container(
         color: Colors.white,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('結算畫面',style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold)),
             SizedBox(height: 40.0,),
             Text('你在該局遊戲中總共選了$counter次',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 8.0,),
             Text('你在該局遊戲中選對了$counter_yes次',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 8.0,),
             Text('你每秒的反應速度為$time秒',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 10.0,),
             ElevatedButton(
                 style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)),
                 onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const BlockHuntermenu())),
                 child: Text("回到主頁",
                     style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
           ],
         ),

    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Block Hunter',
      home: BlockHuntermenu(),
    );
  }
}


void main(){
  runApp(
      const MyApp()
  );
}
