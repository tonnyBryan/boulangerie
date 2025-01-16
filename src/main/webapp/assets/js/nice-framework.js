
class NiceUtil {
    static isBlank(chaine) {
        return chaine.trim() === '';
    }

    static isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    static alert(message, duration = 3000) {
        const snackbar = document.createElement('div');

        // Ajouter du texte au snackbar
        snackbar.textContent = message;

        // Ajouter des styles au snackbar
        snackbar.style.position = 'fixed';
        snackbar.style.top = '20px'; // Position verticale ajustée vers le haut
        snackbar.style.right = '20px'; // Position horizontale ajustée vers la droite
        snackbar.style.backgroundColor = '#333';
        snackbar.style.color = '#fff';
        snackbar.style.padding = '16px';
        snackbar.style.borderRadius = '4px';
        snackbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.3)';
        snackbar.style.opacity = '0';
        snackbar.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        snackbar.style.zIndex = '9999';

        // Ajouter le snackbar au document
        document.body.appendChild(snackbar);

        // Forcer un reflow pour permettre l'animation
        snackbar.offsetHeight;

        // Afficher le snackbar
        snackbar.style.opacity = '1';
        snackbar.style.transform = 'translateY(0)';

        // Masquer le snackbar après la durée spécifiée
        setTimeout(() => {
          snackbar.style.opacity = '0';
          snackbar.style.transform = 'translateY(-100%)';

          // Retirer le snackbar du DOM après l'animation
          snackbar.addEventListener('transitionend', () => {
            snackbar.remove();
          });
        }, duration);
    }
}
class NiceForm {

    constructor(idForm) {
        const form = document.getElementById(idForm);
        if (!form) {
            throw Error("undefined form Id");
        }

        this.idForm = idForm;
    }

    getFormElement() {
        return document.getElementById(this.idForm);
    }

    getData() {
        return NiceForm.getFormData(this.idForm);
    }

    getDataToObject() {
        return NiceForm.getFormDataToObject(this.idForm);
    }

    isAllInputCompleted() {
        return NiceForm.isAllInputCompleted(this.idForm);
    }

    reset() {
        this.getFormElement().reset();
    }

    clear() {
        const form = document.getElementById(this.idForm);

        if (form) {
            Array.from(form.elements).forEach(input => {
                if (input.tagName === 'INPUT' || input.tagName === 'TEXTAREA') {
                    input.value = '';
                } else if (input.tagName === 'SELECT') {
                    input.selectedIndex = 0;
                }
            });
        } else {
            console.warn(`Le formulaire avec l'ID "${formId}" n'existe pas.`);
        }
    }

    fetch($http , url, method) {
        return NiceHttp.fetch($http, url, method, this.getDataToObject());
    }

    static getFormData(idForm) {
        const form = document.getElementById(idForm);

        if(!form) {
            throw Error("undefined form Id");
        }
        const formData = new FormData(form);
        Array.from(form.elements).forEach(element => {
            if (element.tagName.toLowerCase() === 'button' || element.type === 'submit' || element.type === 'hidden') {
                return;
            }

            if (element.type === 'checkbox') {
                formData.append(element.name, element.checked);
            } else {
                formData.append(element.name, element.value);
            }
        });
        return formData;
    }

    static getFormDataToObject(idForm) {
        const formData = NiceForm.getFormData(idForm)
        const formObject = {};

        formData.forEach((value, key) => {
            formObject[key] = value;
        });

        return formObject;
    }

    static isAllInputCompleted(idForm) {
        const obj = NiceForm.getFormDataToObject(idForm);
        Object.entries(obj).forEach(([key, value]) => {
            if (NiceUtil.isBlank(value)) {
                throw Error(key + ' field is Empty');
            }
        });
        return true;
    }
}

class NiceHttp {
    static fetch($http, url, method, data) {
        var requestConfig = {
            method: method.toUpperCase(),
            url: url
        };

        if (['POST', 'PUT', 'PATCH'].includes(method.toUpperCase())) {
            requestConfig.headers = {
                'Content-Type': 'application/json'
            };
            requestConfig.data = data;
        } else if (method.toUpperCase() === 'GET' && data) {
            requestConfig.params = data;
        }

        return $http(requestConfig)
            .then(response => response.data)
            .catch(error => {
                throw error;
            });
    }
}
