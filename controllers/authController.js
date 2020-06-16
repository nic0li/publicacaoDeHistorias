const bcrypt = require("bcrypt");
const { Usuario } = require("../models");
const { Op } = require("sequelize");


const authController = {

    home: (req, res) => {
        const logado = req.session.usuario;
        if (!logado) {
            return res.render("index", { title: "Início" });
        } else {
            return res.redirect("/home");
        }
    },

    admin: (req, res) => {
        const logado = req.session.usuario;
        if (!logado) {
            return res.render("auth/admin", { title: "Admin" });
        } else {
            return res.redirect("/admin/painel");
        }
    },

    painel: (req, res) => {
        return res.render("painel", { title: "Painel Admin" });
    },

    index: (req, res) => {
        return res.render("home", { title: "Início" });
    },

    create: (req, res) => {
        const logado = req.session.usuario;
        if (!logado) {
            return res.render("auth/login", { title: "Entre" });
        } else {
            return res.redirect("/home");
        }
    },

    store: async (req, res) => {
        const { login, senha } = req.body;
        const [usuario] = await Usuario.findAll({
            where: {[Op.or]:[
                { email: login }, 
                { nomeUsuario: login },
            ]},
        });
        if (!usuario || !bcrypt.compareSync(senha, usuario.senha)) {
            return res.render("auth/login", {
                title: "Entre",
                erroLogin: "E-mail ou senha incorretos!", 
            });
        };
        req.session.usuario = {
            id: usuario.id,
            nomeUsuario: usuario.nomeUsuario,
            email: usuario.email,
        };
        return res.redirect("/home");
    },

    destroy: (req, res) => {
        req.session.usuario = undefined;
        return res.redirect("/");
    },

};

module.exports = authController;
