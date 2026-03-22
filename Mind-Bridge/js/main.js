document.addEventListener('DOMContentLoaded', () => {
  // Find the chart container for the Emotional State chart
  const chartContainer = document.getElementById('emotionalChart');
  if (chartContainer) {
    // Data for each day (value1: filled bar, value2: background bar)
    const data = [
      { day: '16 Aug', value1: 40, value2: 60 },
      { day: '17 Aug', value1: 50, value2: 70 },
      { day: '18 Aug', value1: 45, value2: 65 },
      { day: '19 Aug', value1: 70, value2: 90 },
      { day: '20 Aug', value1: 30, value2: 50 },
      { day: '21 Aug', value1: 40, value2: 60 },
      { day: '22 Aug', value1: 20, value2: 40 },
    ];

    // Render each bar group for the chart
    data.forEach(item => {
      // Create a group for each day's bar and label
      const barGroup = document.createElement('div');
      barGroup.className = 'chart-bar-group';

      // Wrapper for the bar (background and fill)
      const barWrapper = document.createElement('div');
      barWrapper.className = 'chart-bar-wrapper';

      // Background bar (shows the max possible value)
      const barBg = document.createElement('div');
      barBg.className = 'chart-bar-bg';
      barBg.style.height = `${item.value2}%`;

      // Filled bar (shows the actual value)
      const barFill = document.createElement('div');
      barFill.className = 'chart-bar-fill';
      barFill.style.height = `${item.value1}%`;

      // Add background and fill to the wrapper
      barWrapper.appendChild(barBg);
      barWrapper.appendChild(barFill);

      // Label for the day
      const label = document.createElement('div');
      label.className = 'chart-label';
      label.textContent = item.day;

      // Assemble the group and add to the chart
      barGroup.appendChild(barWrapper);
      barGroup.appendChild(label);
      chartContainer.appendChild(barGroup);
    });
  }
});
