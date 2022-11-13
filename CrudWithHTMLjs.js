let f = document.querySelector('#insertForm');
console.log(f);

//javascript kod ne radi dobro u ASP.NET Web Forms zbog postojanja
// form taga u Site master-u, zato podvlaci form tag zelenom bojom na aspx stranici
//zbog toga kontrolu unosa cemo validirati na strani servera

f.addEventListener('submit', function (ev) {

    const greska = document.querySelector('#error');

    let lastNameField = document.querySelector('#LastName');
    let lastName = lastNameField.value.trim();

    if (lastName === '') {

        greska.textContent = 'Insert last name!';

        lastNameField.focus();

        ev.preventDefault();

        return false;
    }

    let firstNameField = document.querySelector('#FirstName');
    let firstName = firstNameField.value.trim();

    if (firstName === '') {

        greska.textContent = 'Insert first name!';

        firstNameField.focus();

        ev.preventDefault();

        return false;
    }

    return true;
});