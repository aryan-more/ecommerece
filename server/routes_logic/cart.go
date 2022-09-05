package routes_logic

import (
	"context"
	"fmt"

	"net/http"
	"time"

	"aryan.more/ecom/db"
	"aryan.more/ecom/models"
	"aryan.more/ecom/response"
	"github.com/labstack/echo/v4"
)

func UpdateCart(c echo.Context) error {
	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	id := c.QueryParam("id")
	defer cancel()
	var update models.CartUpdateBody

	err := c.Bind(&update)
	if err != nil {
		fmt.Println(err.Error())
	}
	if id == "" || len(update.Products) == 0 {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Invalid body"})
	}
	for _, product := range update.Products {

		var err error
		if product.Quantity == 0 {

			_, err = db.DB.QueryContext(ctx, "DELETE FROM cart WHERE product=$2 and userid=$1", id, product.ProductId)

		} else {

			_, err = db.DB.QueryContext(ctx, "INSERT INTO public.cart(userid, product, quantity) VALUES ($1, $2, $3) ON CONFLICT ON CONSTRAINT cart_unique DO  UPDATE SET   quantity = $3", id, product.ProductId, product.Quantity)
		}
		if err != nil {
			fmt.Println(err.Error())
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: "Something went wrong"})
		}
	}

	return c.JSON(http.StatusOK, response.ErrorResponse{Msg: "Added Succesfully"})
}
