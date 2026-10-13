/* A normal GCC replacement must fail parsing this ICK-only assignment. */
int main(void) {
    int meaning = 3;
    meaning ← meaning + 4;
    return meaning == 7 ? 0 : 1;
}
