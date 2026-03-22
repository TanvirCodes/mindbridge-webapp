document.addEventListener('DOMContentLoaded', () => {
  // --- Appointments Data ---
  // Time scale: 9am = 0px, 10am = 120px, 11am = 240px, etc. (1 hour = 120px)
  const appointments = [
    // Col 1: Darlene Robertson
    { col: 'col-darlene', top: 120, height: 100, title: 'Nichols Family', type: 'Family Consultation', time: '', dot: '', striped: false },
    { col: 'col-darlene', top: 260, height: 100, title: 'Adam Bridges', type: 'Private Consultation', time: '09:00 am - 10:00 am', dot: '#c084fc', striped: false },
    { col: 'col-darlene', top: 380, height: 100, title: 'Teresa Moore', type: 'Private Consultation - Child', time: '09:00 am - 10:00 am', dot: '#fde047', striped: false },
    { col: 'col-darlene', top: 600, height: 100, title: 'Nichols Family', type: 'Family Consultation', time: '', dot: '', striped: false },

    // Col 2: Michael Thompson
    { col: 'col-michael', top: 20, height: 100, title: 'Ruby Jackson', type: 'Private Consultation', time: '09:00 am - 10:00 am', dot: '#93c5fd', striped: true },
    { col: 'col-michael', top: 200, height: 100, title: 'Darlene Robertson', type: 'Group Consultation', time: '09:00 am - 10:00 am', dot: '#93c5fd', striped: false },
    { col: 'col-michael', top: 440, height: 100, title: 'Shirley Cummings', type: 'Private Consultation', time: '02:30 am - 03:30 am', dot: '#93c5fd', striped: false },

    // Col 3: Max Worthington
    { col: 'col-max', top: 20, height: 140, title: 'Darlene Robertson', type: 'Group Consultation', time: '09:00 am - 10:30 am', dot: '#93c5fd', striped: true },
    { col: 'col-max', top: 240, height: 140, title: 'Diane Walker', type: 'Private Consultation - Child', time: '12:00 am - 1:30 pm', dot: '#fde047', striped: false },
    { col: 'col-max', top: 500, height: 100, title: 'Sean Duncan', type: 'Private Consultation', time: '02:00 pm - 03:00 pm', dot: '#c084fc', striped: false },

    // Col 4: Dr. McCoy
    { col: 'col-mccoy', top: 120, height: 100, title: 'Max Worthington', type: 'Group Consultation', time: '', dot: '', striped: false },
    { col: 'col-mccoy', top: 360, height: 100, title: 'Nichols Family', type: 'Family Consultation', time: '09:00 am - 10:00 am', dot: '#86efac', striped: false },
  ];

  // --- Render Appointments on Calendar ---
  appointments.forEach(app => {
    const col = document.getElementById(app.col);
    if (col) {
      // Create appointment card
      const card = document.createElement('div');
      card.className = `appointment-card ${app.striped ? 'striped' : ''}`;
      card.style.top = `${app.top}px`;
      card.style.height = `${app.height}px`;

      // Build card content
      let innerHTML = `
        <h4>${app.title}</h4>
        <p>${app.type}</p>
      `;
      if (app.time) {
        innerHTML += `<span class="time">${app.time}</span>`;
      }
      if (app.dot) {
        innerHTML += `<div class="status-dot" style="background-color: ${app.dot};"></div>`;
      }
      card.innerHTML = innerHTML;
      col.appendChild(card);
    }
  });

  // --- Draw connecting line for Nichols Family ---
  const line = document.getElementById('nichols-line');
  if (line) {
    line.style.top = '170px'; // Middle of the 10am card (120 top + 50 half height)
    line.style.left = '0';
    line.style.width = '85%'; // Spans across 3.5 columns
  }

  // --- Checkbox filter interactions (visual only) ---
  const checkboxes = document.querySelectorAll('.custom-checkbox-container input');
  checkboxes.forEach(cb => {
    cb.addEventListener('change', (e) => {
      // In a real app, this would filter the calendar
      console.log('Filter toggled:', e.target.nextElementSibling.nextElementSibling.textContent.trim(), e.target.checked);
    });
  });
});
