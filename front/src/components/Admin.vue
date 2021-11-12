<template>
    <v-container fill-height fluid>
        <v-col style="border: 1px">
        <div
          max-widht="50">
          <h3 class="center" align-center > 
            {{ "Search an user by name or firstname" }} 
          </h3>

          <v-autocomplete

          clearable
          deletable-chips
          dense
          rounded
          solo
          v-model = "pickedValue"
          :items="peoplesData"
          item-text="username"
          item-value="username"
          item-key="email"
          @change="choice(pickedValue)"
          ></v-autocomplete>
          <v-card
            v-if="this.peopleHaveBeenSelected"
            elevation = "5"
            max-widht = "50%"
            min-height="100">
            
            <p> {{ this.dataToDisplay.username}} </p>

            <p>
            {{ this.dataToDisplay.age}} 
            </p>
            <p>
            {{ this.dataToDisplay.email}} 
            </p>
          </v-card>
        </div>
        </v-col>
      <v-row cols="3" >
        
          <div v-if="this.showCalendar"> 
            <v-date-picker v-model="pickedDate" @change="dayButtonClick(pickedDate)">
            </v-date-picker>
          </div>

          <v-card
            v-if="this.showWorkingTimes"
            elevation = "5">

            <v-divider></v-divider>
            <p> {{ "Worked time of " + this.dataToDisplay.username + " on the " + this.dateToString}} </p>
            <v-divider></v-divider>
          </v-card>
      </v-row>
      <v-row>
        <v-btn class="button" color="info" v-on:click="addWorkingTime()" flat>
          ADD
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn class="button" color="info" v-on:click="deleteWorkingTime()" :large="$vuetify.breakpoint.smAndUp">
          DELETE
        </v-btn>
      </v-row>
    </v-container>
</template>

<script>
// import userInfo from "./userInfo";
// import WorkingTimes from "./WorkingTimes";

export default {
  name: "User",
  components: {
    // userInfo,
    // WorkingTimes
  },
  methods : {

    dayButtonClick(date){
      this.showWorkingTimes = true
      this.dateAnalyse(date)
    },
    dateAnalyse(dateRawEntry){
      // 2021-11-20 dateRawEntry
      const dateSplit = dateRawEntry.split('-')  
      this.dateCleanEntry = dateRawEntry

      // Get month from month number
      this.monthEntry = this.monthItems[dateSplit[1]-1].month

      this.dateToString = dateSplit[2] + " " + this.monthEntry + " " + dateSplit[0]
      console.log(this.dateToString)
    },

    choice(username){
      this.showCalendar = true
      console.log(this.showCalendar)
      const map1 = this.peoplesData.map(people => 
      {
        if (people.username === username) this.dataToDisplay = people
      });

      this.dataToString = this.dataToDisplay.username + " " + this.dataToDisplay.age + " " + this.dataToDisplay.email

      console.log(find, map1);
      this.peopleHaveBeenSelected = true
      this.getAllData()
    },
    clear(){
    },

    addWorkingTime(){
    },
    deleteWorkingTime(){
    },

    async getAllData() {
      let response = await fetch("http://ligne7.pepintrie.fr:4000/users", 
      { method: 'GET',
        mode: 'cors',
        headers: {
          'Access-Control-Allow-Origin':'*',
          'Content-Type' : 'application/json'
        },
      })  
      .then((res) => {
        return res.json() })
      .catch((err) => {
        console.log(err) })
      
      this.dataTest = await response.json()
      console.log(response)
    }
    
  },

  data () {
    return {
      peopleHaveBeenSelected : false,
      showWorkingTimes : false,
      showCalendar : false,
      dataToDisplay : 'NO data to show',
      dataToString : '',
      dataTest : [],
      dateCleanEntry : '',
      dateToString : '',
      pickedDate : '',

      people: [
        { name: 'Sandra Adams', id: '1'},
        { name: 'Ali Connors', id: '2'},
        { name: 'Trevor Hansen', id: '3'},
        { name: 'Tucker Smith', id: '4'},
      ],
      peoplesData: [
        { username: 'Sandra Adams', age: '22', email: 'sandda@epitech.eu' , id: '1'},
        { username: 'Ali Connors', age: '24',email:  'ali@epitech.eu' , id: '2'},
        { username: 'Trevor Hansen', age: '23',email:  'trevor@epitech.eu' , id: '3'},
        { username: 'Tucker Smith', age: '20',email:  'tucker@epitech.eu' , id: '4'},
      ],
       headers: [
        { text: 'username', value: 'username' },
        { text: 'Age', value: 'age' },
        { text: 'Email', value: 'email' },
      ],
      monthItems: [
        { month: 'January' , id:1},
        { month: 'February' , id:2},
        { month: 'March' , id:3},
        { month: 'April' , id:4},
        { month: 'May' , id:5},
        { month: 'June' , id:6},
        { month: 'July' , id:7},
        { month: 'August' , id:8},
        { month: 'September' , id:9},
        { month: 'October' , id:10},
        { month: 'November' , id:11},
        { month: 'December' , id:12},
      ]
    }
  }
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

  min-width: 300;
  max-width: 600;
}
</style>