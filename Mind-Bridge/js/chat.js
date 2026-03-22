document.addEventListener('DOMContentLoaded', () => {
  // Get references to chat UI elements
  const chatInput = document.getElementById('chatInput');
  const sendBtn = document.getElementById('sendBtn');
  const chatHistory = document.getElementById('chatHistory');
  const anonymousToggle = document.getElementById('anonymousToggle');

  // Create a new message bubble (incoming or outgoing)
  function createMessage(text, type) {
    const messageDiv = document.createElement('div');
    messageDiv.className = `message message--${type}`;

    const bubbleDiv = document.createElement('div');
    bubbleDiv.className = 'message__bubble';
    bubbleDiv.textContent = text;

    const timeSpan = document.createElement('span');
    timeSpan.className = 'message__time';

    // Format current time as HH:MM AM/PM
    const now = new Date();
    let hours = now.getHours();
    let minutes = now.getMinutes();
    const ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0' + minutes : minutes;
    timeSpan.textContent = `${hours}:${minutes} ${ampm}`;

    messageDiv.appendChild(bubbleDiv);
    messageDiv.appendChild(timeSpan);
    return messageDiv;
  }

  // Handle sending a message from the user
  function sendMessage() {
    const text = chatInput.value.trim();
    if (text === '') return;

    // Add outgoing message to chat history
    const outgoingMsg = createMessage(text, 'outgoing');
    chatHistory.appendChild(outgoingMsg);

    // Clear input field
    chatInput.value = '';

    // Auto-scroll to bottom
    chatHistory.scrollTop = chatHistory.scrollHeight;

    // Simulate peer supporter reply after 1.5 seconds
    setTimeout(() => {
      const replyText = "I hear you. Thank you for sharing that with me. Let's talk more about it.";
      const incomingMsg = createMessage(replyText, 'incoming');
      chatHistory.appendChild(incomingMsg);
      chatHistory.scrollTop = chatHistory.scrollHeight;
    }, 1500);
  }

  // Send message on button click
  sendBtn.addEventListener('click', sendMessage);

  // Send message on Enter key press
  chatInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
      sendMessage();
    }
  });

  // Handle anonymous mode toggle
  anonymousToggle.addEventListener('change', (e) => {
    if (e.target.checked) {
      console.log('Anonymous Mode Activated');
      // In a real app, this would change the user's identity context
      alert('Anonymous Mode Activated. Your identity is now hidden for new reports.');
    } else {
      console.log('Anonymous Mode Deactivated');
    }
  });

  // Scroll chat to bottom on load
  chatHistory.scrollTop = chatHistory.scrollHeight;
});
