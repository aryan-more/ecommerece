package routes_logic

import (
	"context"
	"net/http"
	"time"

	"aryan.more/ecom/db"
	"aryan.more/ecom/models"
	"aryan.more/ecom/response"
	"github.com/labstack/echo/v4"
)

func GetProducts(c echo.Context) error {

	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	defer cancel()

	queryResult, err := db.DB.QueryContext(ctx, "SELECT id,price,name,description,image FROM products")

	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})
	}

	products := response.ProductSearchResponse{Products: []models.Product{}}

	for queryResult.Next() {
		var product models.Product
		err := queryResult.Scan(
			&product.Id,
			&product.Price,
			&product.Name,
			&product.Description,
			&product.Image,
		)
		if err == nil {
			products.Products = append(products.Products, product)
		}
	}
	return c.JSON(http.StatusOK, products)

}

func SearchProduct(c echo.Context) error {

	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	defer cancel()

	query := c.QueryParam("search")

	// select * from products where LOWER(name) like LOWER('%Pro%')

	query = "%" + query + "%"

	queryResult, err := db.DB.QueryContext(ctx, "SELECT id,price,name,description,image FROM products where LOWER(name) like LOWER($1)", query)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})
	}

	products := response.ProductSearchResponse{Products: []models.Product{}}

	for queryResult.Next() {
		var product models.Product
		err := queryResult.Scan(
			&product.Id,
			&product.Price,
			&product.Name,
			&product.Description,
			&product.Image,
		)
		if err == nil {
			products.Products = append(products.Products, product)
		}
	}
	return c.JSON(http.StatusOK, products)

}
