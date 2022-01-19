let allButtons = document.querySelectorAll("#button"); 



allButtons.forEach(btn => {
    console.log(btn.className);
    if(btn.className == "t")
        btn.disabled = true;
    else
        btn.disabled = false;
});