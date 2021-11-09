<template>
    <v-container fill-height fluid>
        <v-col cols="6" md="6" style="border: 1px">
          <v-row>
            <user-info/>
          </v-row>
          <v-row>
            <user-info/>
          </v-row>
        </v-col>
        <v-col cols="6" md="6" class="justify-center">
          <WorkingTimes/>
        </v-col>
    </v-container>
</template>

<script>
import userInfo from "./userInfo";
import WorkingTimes from "./WorkingTimes";

export default {
  name: "User",
  components: {
    WorkingTimes,
    userInfo,
  }
}
</script>

<style scoped>

</style>