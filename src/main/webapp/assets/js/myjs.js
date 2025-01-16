function createPopup(message, type) {
    // Déterminer le style et l'icône en fonction du type
    const isAlert = type === "alert";
    const icon = isAlert ? "❌" : "✔️"; // Croix rouge pour alert, check vert pour success
    const backgroundColor = "#fff"; // Fond blanc pour le popup
    const borderColor = isAlert ? "#f44336" : "#4CAF50"; // Rouge pour alert, vert pour success
    const textColor = "#333";

    // Créer un overlay sombre pour l'arrière-plan
    const overlay = document.createElement("div");
    overlay.style.position = "fixed";
    overlay.style.top = "0";
    overlay.style.left = "0";
    overlay.style.width = "100%";
    overlay.style.height = "100%";
    overlay.style.backgroundColor = "rgba(0, 0, 0, 0.5)"; // Noir semi-transparent
    overlay.style.zIndex = "9998";

    // Créer un conteneur pour le popup
    const popup = document.createElement("div");
    popup.style.position = "fixed";
    popup.style.top = "50%";
    popup.style.left = "50%";
    popup.style.transform = "translate(-50%, -50%)";
    popup.style.zIndex = "9999";
    popup.style.backgroundColor = backgroundColor;
    popup.style.color = textColor;
    popup.style.padding = "20px";
    popup.style.border = `3px solid ${borderColor}`;
    popup.style.borderRadius = "10px";
    popup.style.boxShadow = "0 4px 10px rgba(0, 0, 0, 0.2)";
    popup.style.textAlign = "center";
    popup.style.fontFamily = "Arial, sans-serif";
    popup.style.minWidth = "300px";

    // Ajouter l'icône au popup
    const iconEl = document.createElement("div");
    iconEl.style.fontSize = "50px";
    iconEl.style.marginBottom = "10px";
    iconEl.style.color = borderColor;
    iconEl.textContent = icon;
    popup.appendChild(iconEl);

    // Ajouter le message au popup
    const messageEl = document.createElement("p");
    messageEl.style.margin = "0";
    messageEl.style.marginBottom = "20px";
    messageEl.style.fontSize = "18px";
    messageEl.style.fontWeight = "bold";
    messageEl.textContent = message;
    popup.appendChild(messageEl);

    // Bouton pour fermer le popup
    const closeButton = document.createElement("button");
    closeButton.textContent = "OK";
    closeButton.style.padding = "10px 20px";
    closeButton.style.border = "none";
    closeButton.style.borderRadius = "5px";
    closeButton.style.backgroundColor = "#2196F3";
    closeButton.style.color = "#fff";
    closeButton.style.cursor = "pointer";
    closeButton.style.fontSize = "16px";
    closeButton.addEventListener("click", () => {
        document.body.removeChild(overlay);
        document.body.removeChild(popup);
    });
    popup.appendChild(closeButton);

    // Ajouter l'overlay et le popup au body
    document.body.appendChild(overlay);
    document.body.appendChild(popup);
}
