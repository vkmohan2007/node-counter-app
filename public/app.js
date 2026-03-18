let count = 0;

const display = document.getElementById('counter');

function updateDisplay() {
    display.textContent = count;

    display.classList.remove('positive', 'negative');
    if (count > 0) display.classList.add('positive');
    else if (count < 0) display.classList.add('negative');

    // Bump animation
    display.classList.remove('bump');
    void display.offsetWidth; // reflow to restart animation
    display.classList.add('bump');
    setTimeout(() => display.classList.remove('bump'), 150);
}

function change(amount) {
    count += amount;
    updateDisplay();
}

function reset() {
    count = 0;
    updateDisplay();
}
