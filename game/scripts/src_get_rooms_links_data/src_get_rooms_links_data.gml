function getNextRoomPxAndPy(nextRoom, dir) {	
	return {
		px: global.rooms_map[$ room_get_name(nextRoom)][$ dir].px,
		py: global.rooms_map[$ room_get_name(nextRoom)][$ dir].py
	}
}