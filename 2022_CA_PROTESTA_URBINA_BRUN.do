********************************************************************************
**************************ANÁLISIS DE CORRESPONDENCIAS**************************
*****************INTERPRETACIÓN DE VÍNCULOS ENTRE CATEGORÍAS********************
**********************POR GUSTAVO URBINA Y ELODIE BRUN**************************
********************************************************************************

/*(1) Para este ejercicio vamos a hacer uso de los datos de la PolDem-Protest 
Dataset 6 European Countries (Kriesi et al., 2020), que como veremos más adelante, 
contiene poco menos de 20 mil observaciones sobre eventos de protesta ocurridos 
durante el periodo 1975-2011 en Austria, Gran Bretaña, Francia, Alemania, Suiza y 
Países Bajos. Mediante dicho acervo de información, pretendemos problematizar la 
relación entre temáticas de movilización, formas de la protesta y contextos de 
ocurrencia, proporcionando una guía muy básica sobre cómo leer e interpretar los 
distintos elementos y resultados que provee el AC*/

/*La base de datos está disponible en el repositorio de GitHub bajo la dirección:
https://github.com/gurbina84/AnalisisMultivariado/blob/master/poldem-protest_6.dta*/

use "D:\Users\gaurbina\OneDrive\Documentos\CES_COLMEX\artículos\2022\ACM RI\BASES\poldem-protest_6.dta", clear


*1) Forma de protesta y meta
tab goal_recode2 form_recode, nofreq row chi
tab goal_recode2 form_recode, nofreq column chi
tab goal_recode2 form_recode


/*2) Para tener una mejor lectura de los datos, procedamos con una recodificación
de las variables de interés*/

recode goal_recode2 (1=1) (2=2) (3=3) ///
	(4/8=4) (999=5), gen(topic)

lab define topic 1 "Cultural" 2 "Ambiental" 3 "Migración" ///
	4 "Bienestar" 5 "Nacionalismo"
lab val topic topic
tab topic form_recode, chi

gen forma=form_recode
lab define forma 2 "Petición" 3 "Festival" 4 "Marchas" ///
	5 "Confrontación" 6 "V.Ligera" 7 "V.Dura"
lab val forma forma


*3) Hagamos una tabla de contingencia con prueba chi-cuadrado
tab topic forma, column chi

/*4) Ahora pidamos un AC y su respectivo gráfico. 
El comando para gráficos de AC, cabiplot está acompañado de varios elementos técnicos
para mejorar la calidad de la imagen*/

ca topic forma, norm(symmetric)
cabiplot, origin title("Análisis de Correspondencias") ///
	subtitle("Temas y formas de la protesta, 1975-2011" "N=19,740") ///
	legend(pos(3) ring(3) col(1) lab(1 Temas) lab(2 Formas) size(*1)) ///
	rowopts(mlabsize(medium) msize(medium)) colopts(mlabsize(medium) msize(medium)) ///
	aspect(1) scale(0.5)

	
/*5) MCA. Ahora pidamos un MCA que incluye una variable adicional de análisis. Esta
vez incluyamos la variable country, para tener como referente al país de interés.
Incluimos la solicitud del gráfico de MCA con opciones técnicas para mejora de la imagen*/

mca country topic forma 
mca country topic forma, method(joint) norm(principal) 
mcaplot, overlay origin ///
	title("Análisis de Correspondencias") ///
	subtitle("País, Forma y Demanda Central, 1975-2011" "N=19,740") ///
	legend(pos(3) ring(3) col(1) lab(1 País) lab(2 Forma) lab(3 Demanda)) ///
	scale(0.5) 
	

