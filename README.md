# as3-square-packing
AS3 Square Packing is an Actionscript 3 tool which will pack random size squares into a given area until it is filled.

Below is an example of the final outcome.

![as3-square-packing](https://www.dropbox.com/s/hmt3rinpg0bqbhl/as3-square-packing.jpg?dl=0&raw=1)

You only need to provide the height and width of the area to fill, the minimum square size and an array if integer sizes to randomly pick from.

    var ui:UIComponent = new UIComponent();
    addElement(ui);
    var sp:SquarePacking = new SquarePacking();
    var squares:Array = new Array(5,10,15,20,25,30);
    sp.fillGrid(500,500,5,squares);
    ui.addChild(sp);

It will recursively pick one of the sizes at random and create a sqaure with the hight and width of that integer. It will then attempt to place that square in the top left corner. If it fits (without covering another square or flowing off the right side) it will place the square down, then repeat. Once it fills a row to the end of the given area, it will then move down and continue from there.

This can be used to fill an area with images or other MoviceClips.
