## Coursera_IOS3_ISBN-Search
###OBSERVACION:
El boton para Limpiar (Clear Button), del campo de texto, esta seteado para que este siempre visible (Always visible). 

En la documentacion de Swift dice:

"The Clear button only appears when there is text shown in the text field, not the placeholder. Even if you select the “Is always visible” option, it will not appear when only placeholder text appears."

por lo que el boton estara siempre visible si hay texto en el campo de texto, si no lo hay no aparece porque no hay nada que borrar.

Por esto, que me significó una duda, creé un boton extra en la interfaz que borra todo y esta visible todo el tiempo.
