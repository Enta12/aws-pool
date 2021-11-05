<template>
  <v-container>
      <v-layout wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" light tag="section">
            <v-card-title align-center>
                <h3 class="headline " > 
                  {{ platformDay }}
                </h3>
              
            </v-card-title>
            <v-divider></v-divider>

            

              <button id="1" class="day button" v-on:click="dayButtonClick(1)" name="Monday">M</button>
              <button id="2" class="day button" v-on:click="dayButtonClick(2)" name="Tuesday">T</button>
              <button id="3" class="day button" v-on:click="dayButtonClick(3)" name="Wednseday">W</button>
              <button id="4" class="day button" v-on:click="dayButtonClick(4)" name="Thursday">T</button>
              <button id="5" class="day button" v-on:click="dayButtonClick(5)" name="Friday">F</button>
              <button id="6" class="day button" v-on:click="dayButtonClick(6)" name="Saturday">S</button>
              <button id="7" class="day button" v-on:click="dayButtonClick(7)" name="Sunday">S</button> 

            <v-divider></v-divider>
            <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
              <v-btn color="info" flat @click="SignUp">
                RETURN
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>
      <v-layout v-if="this.showHour" wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" light tag="section">
            <v-card-title>
              <v-layout align-center justify-space-between>
                <h3 class="headline" > 
                  {{ platformHour }}
                </h3>
              </v-layout>
            </v-card-title>

            <v-divider></v-divider>
                <!-- 
                  <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label> 00h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 12h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 01h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 13h  </label>
                </div>  
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 02h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 14h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 03h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 15h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 04h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 16h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 05h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 17h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 06h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 18h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 07h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 19h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 08h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 20h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 09h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 21h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 10h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 22h  </label>
                </div>
                <div>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 11h  </label>
                  <input class="hourCheck" type="checkbox"  name=" 00h"  >
                  <label for=" 00h"> 23h  </label>
                </div> 
                
            <v-divider></v-divider>
            -->


              <ul v-for="item, time in 12" :key="item.x">
                  <input class="hourCheck" type="checkbox" >
                  <label> {{ time }}h  </label>
                  <input class="hourCheck" type="checkbox" >
                  <label> {{ time+12 }}h</label>
              </ul>

            <v-divider></v-divider>
            <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
              <v-btn color="info" v-on:click=" clear()" flat @click="SignUp">
                RETURN
              </v-btn>
              <v-spacer></v-spacer>
              <v-btn color="info" v-on:click=" confirm()" :large="$vuetify.breakpoint.smAndUp">
                CONFIRM
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>
      <p v-if="this.confirmed" > {{ this.hourCount }} hours have been added to {{ this.activeDay }} </p>

  </v-container>
  
</template>

<script>
export default {
  methods : {
    dayButtonClick(id){
      this.hourCount = 0
      this.activeDay = this.items[id].day
      if (this.dayAlreadyUp){
        this.setDaystoOff()
        this.setDaytoUp(id) 
      }
      else { 
        this.dayAlreadyUp = true
        this.showHour = true
        this.setDaytoUp(id)
      }

    },
    confirm(){
      // Count how many box are checked
      for (const element of document.getElementsByClassName("hourCheck")){
        if(element.checked) this.hourCount += 1;
      }
      // Clear the interface
      this.clear()
      this.confirmed = true
      return 0
    },
    clear(){
      this.setDaystoOff()
      this.dayAlreadyUp = false
      this.showHour = false
    },

    setDaystoOff(){
      var days = document.getElementsByClassName("day button");
      for(var dayID = 1; dayID <= days.length; dayID++) {
        let element = document.getElementById(dayID)
        element.style.backgroundColor = this.notActiveDayColor 
      }
      for (const element of document.getElementsByClassName("hourCheck")){
        element.checked = false;
      }
    },
    setDaytoUp(id){
        let element = document.getElementById(id)
        element.style.backgroundColor = this.activeDayColor 
    },  


    setHourToUncheck(){
      for (const element of document.getElementsByClassName("hourCheck")){
        element.checked = false;
      }
    }
  },


  data () {
    return {
      darkTheme: true,
      platformDay: 'Choose a day',
      platformHour: 'Check worked hours ',
      activeDay : '',
      email: null,
      username: null,
      showHour : false,
      dayAlreadyUp : false,
      confirmed : false,
      notActiveDayColor : "#04AA6D",
      activeDayColor : "#2196f3",
      hourCount : 0,
      day : String,

      items: [
        { day: 'Monday' , id:1},
        { day: 'Tuesday' , id:2},
        { day: 'Wednesday' , id:3},
        { day: 'Thursday' , id:4},
        { day: 'Friday' , id:5},
        { day: 'Saturday' , id:6},
        { day: 'Sunday'  , id:7},
      ]
    }
  },
}
</script>

<style scoped>

.button {
  background-color: #04AA6D; /* Green */
  border: none;
  color: white;
  padding: 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 50%;
}
.center{
  text-align: center;
}

</style>