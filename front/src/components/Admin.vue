<template>
    <v-container fill-height fluid>
        <v-col cols="6" md="6" style="border: 1px">
    
          <h3 class="center" align-center > 
            {{ "Search an user by name or firstname" }} 
          </h3>

          <v-autocomplete
          clearable
          deletable-chips
          dense
          filled
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
            min-width="374"
            min-height="100">
            <p>
            {{ this.dataToDisplay.username}}
            </p>
            <p>
            {{ this.dataToDisplay.age}} 
            </p>
            <p>
            {{ this.dataToDisplay.email}} 
            </p>
          </v-card>
            <v-btn class="button" color="info" v-on:click=" clear()" flat @click="SignUp">
              ADD
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn class="button" color="info" v-on:click="confirm(dateRawEntry)" :large="$vuetify.breakpoint.smAndUp">
              DELETE
            </v-btn>
        </v-col>
        


        <v-col cols="1" md="6">
            <WorkingTimes/>
        </v-col>
    </v-container>
</template>

<script>
// import userInfo from "./userInfo";
import WorkingTimes from "./WorkingTimes";

export default {
  name: "User",
  components: {
    // userInfo,
    WorkingTimes
  },
  methods : {
    choice(username){
      const map1 = this.peoplesData.map(people => 
      {
        if (people.username === username) this.dataToDisplay = people
      });

      this.dataToString = this.dataToDisplay.username + " " + this.dataToDisplay.age + " " + this.dataToDisplay.email

      console.log(find, map1);
      this.peopleHaveBeenSelected = true
      this.getAllData()
    },

    async getAllData() {
      let response = await fetch("http://ligne7.pepintrie.fr:4000/users", 
      { method: 'GET',
        mode: 'cors',
        headers: {
          'Access-Control-Allow-Origin':'*'
        }
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
      dataToDisplay : 'NO data to show',
      dataToString : '',
      dataTest : [],


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
    }
  }
}
</script>

<style scoped>
.Column{

}
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