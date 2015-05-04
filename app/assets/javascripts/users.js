function toggle(obj) {

	var element = document.getElementById(obj);

	if ( element.style.display != 'none' ) {

		element.style.display = 'none';

	}

	else {

		element.style.display = '';

	}

}