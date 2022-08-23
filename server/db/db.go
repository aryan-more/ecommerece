package db

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func Connect() *sql.DB {
	host := "127.0.0.1"
	port := "5432"
	user := "postgres"
	password := "P35Bxzz6K"
	dbname := "ecom"

	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
	result, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		log.Fatalf("Tidak Konek DB Errornya : %s", err)
	}
	return result
}

var DB *sql.DB = Connect()
