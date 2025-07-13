document.addEventListener('DOMContentLoaded', function () {
  const calendarEl = document.getElementById('calendar');
  const dropZoneEl = document.getElementById('calendarDropZone');
  const poiList = document.getElementById('microTripResult');

  // 🗓️ Initialize FullCalendar
  const calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'timeGridDay',
    editable: true,
    droppable: true,
    height: 'auto',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'timeGridDay,timeGridWeek,dayGridMonth'
    },
    drop: function (info) {
      console.log(`🗓️ Dropped: ${info.draggedEl.innerText}`);
    }
  });
  calendar.render();

  // ✅ Enable POI elements to be draggable
  function makePOIsDraggable() {
    if (!poiList) return;
    new FullCalendar.Draggable(poiList, {
      itemSelector: '.poi-card',
      eventData: function (el) {
        return {
          title: el.querySelector('strong')?.innerText || 'POI',
          duration: el.getAttribute('data-duration') + 'm'
        };
      }
    });
  }

  // 🧠 Listen to form submission for microtrip generation
  const form = document.getElementById('microTripForm');
  if (form) {
    form.addEventListener('submit', async function (e) {
      e.preventDefault();

      const location = form.location.value;
      const selectedInterests = Array.from(form.interests.selectedOptions).map(opt => opt.value);
      const budget = form.budget.value ? parseFloat(form.budget.value) : null;

      const data = {
        current_location: location,
        interests: selectedInterests,
        budget: budget
      };

      try {
        const res = await fetch('http://localhost:5000/api/microtrip/generate', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        });

        const result = await res.json();
        poiList.innerHTML = '';

        if (result.recommended && result.recommended.length > 0) {
          result.recommended.forEach((poi) => {
            const li = document.createElement('li');
            li.className = 'poi-card';
            li.setAttribute('data-duration', poi.duration_minutes || 60);
            li.innerHTML = `
              <strong>${poi.name}</strong><br/>
              <small>${poi.interest}</small><br/>
              <span>${poi.duration_minutes || 60} min, ${poi.opening_time}–${poi.closing_time}</span>
            `;
            poiList.appendChild(li);
          });

          makePOIsDraggable();

          document.getElementById("saveTripBtn").style.display = "inline-block";
          document.getElementById("syncCalendarBtn").style.display = "inline-block";
        } else {
          poiList.innerHTML = '<p>No suggestions found.</p>';
        }
      } catch (err) {
        console.error('Error:', err);
        alert('Something went wrong generating microtrip.');
      }
    });
  }

});
