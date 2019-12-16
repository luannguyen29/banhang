function days() {
	var mo = document.getElementById("month");
	var m = mo.options[mo.selectedIndex].value;
	var month = parseInt(m);

	if (month === 1 || month === 3 || month === 5 || month === 7 || month === 8
			|| month === 10 || month === 12) {
		return 31;
	} else if (month === 4 || month === 6 || month === 9 || month === 11) {
		return 30;
	}

	var sel = document.getElementById("year");
	var text = sel.options[sel.selectedIndex].value;
	var yearint = parseInt(text);
	if (((yearint % 4 == 0) && (yearint % 100 != 0)) || (yearint % 400 == 0)) {
		return 29;
	} else
		return 28;
}

function definedays() {

	var select = document.getElementById("day");
	var l = document.getElementById("day").length;
	var len = parseInt(l);
	var i = 1;
	if (days() == 30) {
		if (len == 31)
			select.remove(30);
		else {
			for (i = len + 1; i < 31; i++) {
				var option = document.createElement('option');
				option.text = option.value = i;
				select.appendChild(option);
			}
		}
	}
	if (days() == 31) {

		if (len != 31) {
			for (i = len + 1; i < 32; i++) {
				var option = document.createElement('option');
				option.text = option.value = i;
				select.appendChild(option);
			}
		}

	}

	if (days() == 28) {
		if (len === 31) {
			select.remove(30);
			select.remove(29);
			select.remove(28);

		}

		if (len === 30) {
			select.remove(29);
			select.remove(28);
		}
	}

	if (days() == 29) {
		if (len === 31) {
			select.remove(30);
			select.remove(29);

		}

		if (len === 30) {
			select.remove(29);
		}
	}

}
