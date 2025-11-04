# BUGS.md

### Bug 1 – Movie model not nullable
Issue:`director` and `rating` were required but should be optional.  
Fix: Made them `String?` and `int?` in `Movie` to match the spec.

---

### Bug 2 – Wrong DB schema & update logic
Issue: `year` stored as `TEXT`; `updateMovie` always edited `id=1`.  
Fix: Changed schema to `INTEGER NOT NULL`, used `movie.id` in update.

---

### Bug 3 – Missing delete method
Issue: No way to remove movies.  
Fix: Added `deleteMovie(int id)` in `MovieManager`.

---

### Bug 4 – Form validation errors
Issue: Crashed on invalid year, didn’t require rating for watched movies.  
Fix: Added numeric + range validation and rating check with error message.

---

### Bug 5 – SharedPreferences issues
Issue: Typos in key names, dark mode not loading.  
Fix: Unified keys, added `_keyIsFirstRun`, and loaded saved theme.

---

### Bug 6 – UI null bugs
Issue: `director.isNotEmpty` on null, wrong icons, wrong list index.  
Fix: Added null checks, correct icons, used `_movies[index]`.

---

### Bug 7 – List not refreshing
Issue: Ignored `result` after add/edit.  
Fix: Reloaded `_loadData()` when `result == true`.

---

### Bug 8 – StarRating bugs
Issue: Off-by-one rating and interactive when not watched.  
Fix: Used `index + 1` and disabled taps when `isWatched` is false.

---

**Result:** All automated tests (`db`, `prefs`, `ui`) now pass 100%.
