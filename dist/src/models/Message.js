"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Message {
    constructor(id_emetteur, id_recepteur, contenu, date) {
        this.id_user_emetteur = id_emetteur;
        this.id_user_recepteur = id_recepteur;
        this.contenu_message = contenu;
        this.date_envoi = date;
    }
}
exports.default = Message;