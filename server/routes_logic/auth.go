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
	"golang.org/x/crypto/bcrypt"
)

func SignUp(c echo.Context) error {
	var user models.SignUpBodyModel
	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	defer cancel()
	err := c.Bind(&user)
	if err != nil || len(user.EMAIL) == 0 {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Invalid body"})
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(user.PASSWORD), bcrypt.DefaultCost)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})

	}

	user.PASSWORD = string(hashed)

	result, err := db.DB.QueryContext(ctx, "SELECT email, phone FROM users WHERE email=$1 OR phone=$2", user.EMAIL, user.PHONE)

	if err != nil {

		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})

	} else if result.Next() {
		var email, phone string
		err = result.Scan(&email, &phone)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})

		}
		if email == user.EMAIL {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Email already exist"})

		} else {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Phone number already exist"})

		}

	}

	_, err = db.DB.QueryContext(ctx, "INSERT INTO public.users(name, email, password, phone)VALUES ( $1, $2, $3, $4)", user.NAME, user.EMAIL, user.PASSWORD, user.PHONE)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Unable to create account"})

	}

	result, err = db.DB.QueryContext(ctx, "SELECT id FROM users WHERE email=$1", user.EMAIL)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Unable to get account info"})

	}
	var id string

	fmt.Println(result)
	if result.Next() {
		err = result.Scan(&id)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Unable to get account info"})

		}
	} else {
		return c.JSON(http.StatusNotFound, response.ErrorResponse{Msg: "User not found"})

	}
	clientCredential, err := response.ClientCredential(models.User{ID: id, EMAIL: user.EMAIL, PHONE: user.PHONE, NAME: user.NAME})

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: err.Error()})
	}
	return c.JSON(http.StatusOK, clientCredential)

}

func SignIn(c echo.Context) error {
	var credential models.SignInBodyModel
	ctx, cancel := context.WithTimeout(c.Request().Context(), time.Second*10)
	defer cancel()
	err := c.Bind(&credential)

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Invalid body"})
	}
	result, err := db.DB.QueryContext(ctx, "SELECT id,name, email, phone, password FROM users WHERE email=$1 OR phone=$1", credential.USERCONTACT)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})

	}
	var user models.User
	if result.Next() {
		err := result.Scan(
			&user.ID,
			&user.NAME,
			&user.EMAIL,
			&user.PHONE,
			&user.PASSWORD,
		)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})
		}

		if bcrypt.CompareHashAndPassword([]byte(user.PASSWORD), []byte(credential.PASSWORD)) != nil {
			return c.JSON(http.StatusUnauthorized, response.ErrorResponse{Msg: "Invalid Password"})
		}

		clientCredential, err := response.ClientCredential(user)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse{Msg: err.Error()})

		}
		return c.JSON(http.StatusOK, clientCredential)

	}

	return c.JSON(http.StatusNotFound, response.ErrorResponse{Msg: "User not found"})

}
