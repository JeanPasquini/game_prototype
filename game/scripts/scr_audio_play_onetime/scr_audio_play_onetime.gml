function scr_make_onetime_sound(sfx = [], emitter = noone, loop = false) {
    var _context = {
        sfx: sfx,
        emitter: emitter,
        played: false,
        loop: loop,
        broken: false,
        playing_id: -1
    };
    return method(_context, function(_reset = false, _break = false, _fade_time = -1) {
        if (_break) {
            if (self.loop && self.playing_id != -1 && audio_is_playing(self.playing_id)) {
                audio_stop_sound(self.playing_id);
            }
            self.playing_id = -1;
            self.broken = true;
            self.played = false;
            return -1;
        }
        if (_reset) {
            self.played = false;
            self.broken = false;
            self.playing_id = -1;
            return -1;
        }
        if (self.broken) return self.playing_id;

        var _sfx = self.sfx;
        if (self.loop) {
            if (self.playing_id == -1 || !audio_is_playing(self.playing_id)) {
                if (self.emitter == noone) {
                    self.playing_id = audio_play_sound(_sfx[irandom(array_length(_sfx) - 1)], 1, true);
                }
                else {
                    self.playing_id = audio_play_sound_on(self.emitter, _sfx[irandom(array_length(_sfx) - 1)], true, 1);
                }
            }
            return self.playing_id;
        }

        // modo onetime
        if (!self.played) {
            if (self.emitter == noone) {
                self.playing_id = audio_play_sound(_sfx[irandom(array_length(_sfx) - 1)], 1, false);
            }
            else {
                self.playing_id = audio_play_sound_on(self.emitter, _sfx[irandom(array_length(_sfx) - 1)], false, 1);
            }
            self.played = true;

            // <<< aplica o fade só nesse instante, uma vez, e só se pedido
            if (_fade_time > 0 && self.playing_id != -1 && audio_is_playing(self.playing_id)) {
                audio_sound_gain(self.playing_id, 0, _fade_time);
            }
        }
        return self.playing_id;
    });
}