package routes_logic

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"aryan.more/ecom/db"
	"aryan.more/ecom/response"
	"github.com/labstack/echo/v4"
)

func UpdatedUserInfo(c echo.Context) error {
	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	defer cancel()

	id := c.QueryParam("id")
	fmt.Println(id)

	result, err := db.DB.QueryContext(ctx, "SELECT name, email, phone FROM users WHERE id=$1", id)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})
	}

	if result.Next() {
		var user response.UpdatedUserInfo
		err := result.Scan(
			&user.NAME,
			&user.EMAIL,
			&user.PHONE,
		)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})
		}
		user.CART = make([]int, 0)

		return c.JSON(http.StatusOK, user)

	}
	return c.JSON(http.StatusNotFound, response.ErrorResponse{Msg: "User not found"})

}
