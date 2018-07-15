function Spinner() {

    this.show = function(message) {
        this.setMessage(message);
        var pb = document.getElementById('spinner');
    	pb.style.display = "flex";
    	setTimeout(function() {
    		pb.classList.add("active");
    	}, 0);
    }

    this.hide = function() {
        var pb = document.getElementById('spinner');
    	pb.classList.remove("active");
    	setTimeout(function() {
    		pb.style.display = "none";
    	}, 500);
    }

    this.setMessage = function(message) {
        if(!message)
            message = 'Loading...';
        var pb = document.getElementById('spinner');
        var messageContainer = pb.querySelector('.progressbar-message');
        messageContainer.innerHTML = message;
    }
}

window.spinner = new Spinner();
window.spinner.show();
