class_name VALORES_DO_INIMIGO
extends Node

var personagem:INIMIGO_BASE

var velocidade_de_movimento:float = 125

var fator_de_aceleracao:float = 0.03

var dano_base:float
var tipo_de_dano:String
var fator_de_dano_especial:float
var barra_afetada:String

var nivel:int
var vida_incial:float
var mana_incial:float
var estamina_incial:float
var forca:float
var destreza:float
var constituicao:float
var resistencias:Array
var fraquezas:Array

var xp_dropada:float
var dinheiro_dropado:int
var chance_de_drop_de_ouro:int
var chance_de_drop_de_potion:int
var chance_de_drop_de_presente:int

