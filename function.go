package terraform_sample

import (
	"fmt"
	"net/http"
	"os"
)

func SampleTerraformFunction(w http.ResponseWriter, r *http.Request)  {
	v := os.Getenv("MY_ENV_VAR")
	fmt.Fprint(w, v)
}
