

class Product:
    def __init__(self,name:str,desc:str,image:str,price:int) -> None:
        self.name = name
        self.desc = desc
        self.price = price
        self.image = image 

    def toInsertQuery(self,cur) -> str:
        cur.execute(
         """ INSERT INTO Products (name, description, price, image)VALUES ( %s, %s, %s, %s)""",
        (self.name, self.desc, self.price, self.image))