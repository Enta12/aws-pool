<template>
  <div class="working-times">
    <v-card elevation="16" class="mx-auto">
      <span class="text-center">
      <strong><h2>WorkingTimes list</h2></strong>
      </span>
      <v-list class="listCard">
         <!-- <template>
                <v-expansion-panels>
                  <v-expansion-panel
                    v-for="(item,i) in 12"
                    :key="i"
                  >
                    <v-expansion-panel-header >
                      {{months[i]}}
                    </v-expansion-panel-header>
                    <v-expansion-panel-content  v-if="month[i] == test" >
                      <v-list-item v-for="i in test" :key="i">

                      </v-list-item>
                     {{i}}

                    </v-expansion-panel-content>
                  </v-expansion-panel>
                </v-expansion-panels>
            </template> -->
              <template>
                <v-expansion-panels focusable  multiple>
                  <v-expansion-panel
                    v-for="(item,i) in 12"
                    :key="i"
                    v-model="panel"
                   
                  >
                    <v-expansion-panel-header class="headpanel ">
                     <span class='text-center'> <h2>{{months[i]}}</h2></span>
                    </v-expansion-panel-header>
                    <v-expansion-panel-content class='justify-center' >
                      
                      
                    <v-expansion-panel
                    v-for="(item,itm) in 7"
                    :key="itm"
                   
                    multiple
                    >
                     <v-expansion-panel-header class="headpanelbis ">
                     <span class='text-center'> <h3>{{days[itm]}}</h3></span>
                    </v-expansion-panel-header>
                       <v-expansion-panel-content class='justify-center' >
                          <v-list >
                         <v-list-item v-for="it in ttest" :key="it" class='justify-center' >
                           <v-card v-if="months[i] == it['monthName'] && days[itm] == it['dayName']" class='cardWorks  ' elevation='12'>
                             <div class='cardWorkst d-inline-flex'>
                          <span class="flex-row "> 
                          <v-card-text> <v-card-subtitle > <h3> {{ it['dayName']}} {{ it['worksdate'][0]['start'][0]}}</h3> </v-card-subtitle></v-card-text></span>
                            <span class=" flex-row">
                           <v-card-text> <v-card-subtitle>Start at : {{it['worksdate'][0]['start'][1]}}</v-card-subtitle></v-card-text>
                            </span>  
                            <span class=" flex-row ">
                           <v-card-text>  <v-card-subtitle>End at :  {{it['worksdate'][1]['end'][1]}}</v-card-subtitle> </v-card-text>
                            </span>
                             </div>
                           </v-card>
   
                      </v-list-item>
                      
                      </v-list>
                       </v-expansion-panel-content>
                    </v-expansion-panel>  
                     
                     


                    </v-expansion-panel-content>
                  </v-expansion-panel>
                </v-expansion-panels>
            </template>
      
      </v-list>

      <v-virtual-scroll
        :items="data_workingtimes"
        class="mycard"
        item-height="45"
      >
        <!-- <template v-slot:default="{ item }" v-if = "responseAvailable == true" >
          
          <v-list-item  :key="item" >

            <v-list-item-action>
              <v-btn
                  fab
                  small
                  depressed
                  color="primary"
              >
               {{ item }}
              </v-btn>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title>
                User Database Record <strong>ID {{ item.id }}</strong>
              </v-list-item-title>
            </v-list-item-content>

            <v-list-item-action>
              <v-icon small>
                mdi-open-in-new
              </v-icon>
            </v-list-item-action>
          </v-list-item>
        
         
          <v-divider></v-divider>
        </template>-->
      </v-virtual-scroll>
    </v-card>
  </div>
</template>

<script>
// const iduser =this.$store.state.user.id;
import axios from "axios";
import moment from "moment";
import Vue from 'vue';

export default {
  name: "WorkingTimes",
  data() {
    return { data_workingtimes: {},test:[],ttest:[],worksdays:[], nbWorks:0,day: [], month: [],months:['January','February','March','April','May','June','July','August','September','October','November','December'],days:['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'], counter: "" };
  },
  async created() {
    
    axios
      .get(
        "http://localhost:4000/api/workingtimes/" + this.$store.state.user.id
      )
      .then((res) => {

        this.data_workingtimes = res.data.data;

      
            res.data.data.forEach(elmt =>{
              // let splitdaystart= moment(elmt.start.format("dddd-MMMM-YY:H:M:A"))
            // let  splitendstart =moment(elmt.end.format("A"))
              let getdaystart = elmt.start.split('T')
              let getdayEnd = elmt.end.split('T')
              let date_Formated = moment(getdaystart[0]).format("dddd MMMM YYYY");
              //  let hour_Formated = moment(getdaystart[1]).format("hh:mm A");

              let month_date = date_Formated.split(" ");
          
         

              this.worksdays.push({'start':getdaystart})
              this.worksdays.push({'end':getdayEnd})
            
              this.worksdays.push({'day':month_date})
              this.worksdays.push(elmt.id)
              let currentday =month_date[0]
              this.nbWorks++
              this.pushWorks(month_date[1],this.worksdays,currentday)
              this.worksdays=[]

              this.test.push(month_date[1],getdaystart[0])
              this.test.push(getdaystart[0])


             
            })
                        

        let test = this.data_workingtimes.map((data) => 
        {
          //  let lastdate= moment(data.start).format('dddd/mm/YY')
          let str_date = data.start.split("T");
          
          let dateFormated = moment(str_date[0]).format("dddd MMMM YY");

          let getday = dateFormated.split(" ");

          this.day.push(getday[0]);
        //     res.data.data.forEach((value, index) => {
        //     // arr.push(value);
        //     // this.allDatas.push(value)
        //     console.log('foreach val',value);
        //     // console.log('test get month',this.allDatas)
        //     console.log('foreach index',index);
        // });
        

         this.month.push(getday[1]);
          this.data_formated = dateFormated;
        });
        return test
       
      })
      .catch((e) => {
        console.error(e);
      });
         
         
  },

  methods: {
    
   
    pushWorks(month,works,day){
      
      this.ttest.push({monthName:month,worksdate:works,dayName:day})
     
    },
    showWorkingTimes(){
      let demo = new Vue({
        el:'#demof',
        data:{
          parentMsg:'YO',
          items:this.ttest
        }

      })
      return demo
    }
  },
};
</script>

<style scoped>
.mycard {
  height: 65vh;
  /* justify-content: center; */
}
.listCard {
  height: 35vh;
  /* justify-content: center; */
  /* align-items: center; */
  /* border:solid black 2;
  border-color: black; */
}
.itemCard {
  background-color: cornflowerblue;
  height: 55%;
  width: 85%;
  border: 3;
  margin: 5%;
  /* margin-left: 10%; */

  border-radius: 20;
}
.cardWorks {
  width: 90%;
  height: 8%;
  flex-direction: row;
  margin:1%
}
.cardWorkst {
  width: 100%;
  flex-direction: row;
  background-color: rgb(37, 209, 157);
}
.scroller {
  height: 100%;
  width: 100%;
}
.datebox {
  background-color: crimson;
  height: 10vh;
  /* flex-direction: row; */
  /* justify-content: space-between; */
}
.startdate {
  font-size: 20;
  background-color: yellow;
  /* flex: 2; */
}
.enddate {
  font-size: 20;
  width: "30%";
  background-color: green;
}
.headpanel {
  justify-content: center;
  text-align: center;
  background-color: rgb(37, 209, 157);
}
</style>