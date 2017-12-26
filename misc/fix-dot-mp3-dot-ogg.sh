for file in *.mp3.ogg; do
    mv "$file" "$(basename "$file" .mp3.ogg).ogg"
done
