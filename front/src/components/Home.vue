<template>
    <v-container fill-height fluid align="center" class="justify-center">
      <v-row justify="center">
        <v-sheet align="center" color="white" elevation="5" height="30%" width="30%">
          <v-col >
            <p>{{this.$store.state.user.isLoggedIn === false ? "Veuillez vous connecter" : "Bonjour "}}</p>
            <v-btn style="margin: 10px" v-on:click="Redirect">{{this.$store.state.user.isLoggedIn === false ? "Se connecter" : "Aller sur votre page utilisateur"}}</v-btn>
            <v-btn style="margin: 10px" v-if="this.$store.state.user.isLoggedIn" v-on:click="Disconnexion"> Déconnexion </v-btn>
            <v-btn style="margin: 10px" v-if="this.$store.state.user.isLoggedIn" v-on:click="Pointer"> Pointer </v-btn>
          </v-col>
        </v-sheet>
      </v-row>
      <v-row justify="center" v-if="this.$store.state.user.isConnected === true">
        <v-sheet align="center" color="white" elevation="5" height="30%" width="30%">
          <p>Vous êtes présent</p>
        </v-sheet>
      </v-row>
    </v-container>
</template>

<script>
import {getDateTime} from "../storeUtils/StoreUtils";

export default {
  name: "Home",
  components : {

  },
  data () {
    return {
      knowledge : 33,
      remaining_time : "",
      pourcentage : 0
    }
  },
  mounted() {
    let test = {clock: {time: "1999-10-10 10:10:10", status: false}}
    if (this.$store.state.user.isConnected) {
      fetch("http://ligne7.pepintrie.fr:4000/api/clocks/" + this.$store.state.user.id, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        method: 'POST',
        body: JSON.stringify(test)
      }).catch((err) => {
        console.log("MY ERROR = ", err)
      })
    }
  },
  methods: {
    GetRemainingTime() {
    },
    async Pointer() {
      let date = getDateTime()
      let tmp = false
        this.$store.commit('SetPointingDate', {date_str :date.date_str, date : date.date})
        if (this.$store.state.user.isConnected === false) {
          if (this.$store.state.user.pointer === "") {
            this.$store.state.user.pointer = date.date_str
          }
              } else {
          let my_data_obj = JSON.stringify({workingtime : {start : this.$store.state.user.pointer.toString(), end : date.date_str.toString() }})
          await fetch("http://ligne7.pepintrie.fr:4000/api/workingtimes/" + this.$store.state.user.id,
            {method : "POST",
            body : my_data_obj,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },}
          ).then((response) => {
            console.log(response)
            return (response.json())
          }).catch((err) => {
            console.log("ERR ON CREATE WORKINGTIME : ", err)
          })
          tmp = true
        }
        let test = {clock: {time: date.date_str, status: !this.$store.state.user.isConnected}}
          fetch("http://ligne7.pepintrie.fr:4000/api/clocks/" + this.$store.state.user.id, {
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            method: 'PUT',
            body: JSON.stringify(test)
          })
              .then(async (response) => {
                console.log("PUT = ", await response.json())
              }).catch((err) => {
            console.log("MY ERROR = ", err)
          })
        this.$store.commit("pointer")
      if (tmp === true)
        this.$store.state.user.pointer = ""
    },
    Redirect() {
      if (this.$store.state.user.isLoggedIn === true) {
        this.$router.push("/User")
      } else {
        this.$router.push("/Login")
      }
    },
    Disconnexion() {
      this.$store.commit("DisconnectUser")
      this.$router.push("/Login")

    }
  }
}
</script>

<style scoped>
.rowmargin {
}
.sheetstyle {
  width: 40%;
  height: 150px;
  margin: 50px;
}
</style>