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
          :items="people"
          item-text="name"
          item-value="name"
          @click="choice()"
          ></v-autocomplete>
          <v-card
            elevation = "5"
            min-width="374"
            min-height="374">
            <template>  
              <v-data-table
                dense
                :headers="headers"
                :items="peoplesData"
                item-key="name"
                class="elevation-1"
              ></v-data-table>
            </template>
          </v-card>
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
    choice(){
      this.peopleHaveBeenSelected = true
      this.dataToDisplay = "XD"
      console.log("DEBUG: HEY choice()")
    },
  },

  data () {
    return {
      peopleHaveBeenSelected : false,
      dataToDisplay : 'NO data to show',

      people: [
        { name: 'Sandra Adams', id: '1'},
        { name: 'Ali Connors', id: '2'},
        { name: 'Trevor Hansen', id: '3'},
        { name: 'Tucker Smith', id: '4'},
      ],
      peoplesData: [
        { age: 'Sandra Adams', email: 'sandda@epitech.eu' , id: '1'},
        { age: 'Ali Connors', email:  'ali@epitech.eu' , id: '2'},
        { age: 'Trevor Hansen', email:  'trevor@epitech.eu' , id: '3'},
        { age: 'Tucker Smith', email:  'tucker@epitech.eu' , id: '4'},
      ],
       headers: [
        { text: 'First Name', value: 'firstname' },
        { text: 'Last Name', value: 'lastname' },
        { text: 'Email', value: 'email' },
      ],
    }
  }
}
</script>

<style scoped>
.Column{

}
</style>