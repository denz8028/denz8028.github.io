// Make the DIV element draggable:
dragElement(document.getElementById("draggable-window"));
const tabs = document.querySelectorAll('.tab');
const tabContents = document.querySelectorAll('.tab-content');
const about = document.getElementById("about");
const closeBtn = document.querySelector('.close-btn');

function dragElement(elmnt) {
    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
    if (document.getElementById("window-header")) {
        // if present, the header is where you move the DIV from:
        document.getElementById("window-header").onmousedown = dragMouseDown;
    } else {
        // otherwise, move the DIV from anywhere inside the DIV:
        elmnt.onmousedown = dragMouseDown;
    }

    function dragMouseDown(e) {
        e = e || window.event;
        e.preventDefault();
        // get the mouse cursor position at startup:
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        // call a function whenever the cursor moves:
        document.onmousemove = elementDrag;
    }

    function elementDrag(e) {
        e = e || window.event;
        e.preventDefault();
        // calculate the new cursor position:
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        // set the element's new position:
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    }

    function closeDragElement() {
        // stop moving when mouse button is released:
        document.onmouseup = null;
        document.onmousemove = null;
    }
}
// Переключение вкладок
tabs.forEach(tab => {
    tab.addEventListener('click', () => {
        // Удаляем активный класс у всех вкладок и контента
        tabs.forEach(t => t.classList.remove('active'));
        tabContents.forEach(c => c.classList.remove('active'));

        // Добавляем активный класс к выбранной вкладке
        tab.classList.add('active');

        // Показываем соответствующий контент
        const tabId = tab.getAttribute('data-tab');
        document.getElementById(tabId).classList.add('active');
    });
});
closeBtn.addEventListener('click', () => {
    document.getElementById("draggable-window").style.display = 'none';
});
about.addEventListener('click', () => {
    document.getElementById("draggable-window").style.display = 'block';
});
