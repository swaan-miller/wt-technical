<script setup lang="ts">
import { onMounted, ref } from 'vue'
import axios from 'axios'

export interface MeetingRooms {
  name: string
  thumbnail: string
  spots: number
  btnText: string
  booked: boolean
}

const rooms = ref(<MeetingRooms[]>[])

onMounted(async () => {
  await axios
    .get('https://wetransfer.github.io/rooms.json')
    .then(
      (res: {
        data: {
          rooms: {
            name: string
            thumbnail: string
            spots: number
            btnText: string
            booked: boolean
          }[]
        }
      }) => (rooms.value = res.data.rooms)
    )
    .catch((err: any) => {
      console.log('error retrieving room data from api: ', err)
    })
  rooms.value.forEach((room) => {
    if (room.spots > 0) {
      room.btnText = 'Book!'
    } else {
      room.btnText = 'Room Full'
    }
  })
})

function bookRoom(name: string, spots: number) {
  rooms.value.forEach((room) => {
    if (room.name == name && room.spots > 0) {
      room.spots--
      room.booked = true
    }
  })
}

function closeBooking(name: string) {
  rooms.value.forEach((room) => {
    if (room.name == name) {
      room.booked = false
    }
  })
}
</script>

<template>
  <div>
    <header>
      <h1>Rooms</h1>
      <p>
        Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ea, amet! Quia ratione ut dolore
        adipisci, veniam laudantium nulla.
      </p>
    </header>
    <div class="rooms">
      <div v-for="room in rooms" :key="room.name" class="one-room">
        <img :src="room.thumbnail" />
        <span class="room-name">{{ room.name }}</span>
        <span class="spots-remain">{{ room.spots }} spots remaining</span>
        <button @click="bookRoom(room.name, room.spots)">{{ room.btnText }}</button>
        <div class="booked" v-if="room.booked">
          You have succesfully booked the {{ room.name }} room!
          <button @click="closeBooking(room.name)">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
header {
  padding-bottom: 5vh;
}

p {
  color: grey;
}

.rooms {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-rows: 1fr 1fr;
  grid-gap: 20px;
}

@media screen and (min-width: 601px) and (max-width: 900px) {
  .rooms {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 1fr 1fr;
    grid-gap: 10px;
  }
}

@media screen and (max-width: 600px) and (min-width: 401px) {
  .rooms {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: auto;
  }
}

@media screen and (max-width: 400px) {
  .rooms {
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: auto;
  }
}
.one-room {
  display: grid;
  grid-template-areas:
    'img img'
    'room btn'
    'text btn';
}
.one-room > img {
  object-fit: cover;
  width: 100%;
  border-radius: 15px;
  grid-area: img;
  padding-bottom: 10px;
}
.spots-remain {
  grid-area: text;
  color: purple;
}
.room-name {
  font-weight: bold;
  grid-area: room;
}
button {
  border-radius: 5px;
  border-style: none;
  background-color: #9f0086;
  color: white;
  font-weight: bold;
  padding: 5px;
  cursor: grab;
  grid-area: btn;
  height: 3vh;
}
</style>
