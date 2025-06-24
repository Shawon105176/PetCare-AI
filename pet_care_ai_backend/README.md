# PetCare AI Backend (FastAPI)

## Setup

1. Create a virtual environment (optional but recommended):
   ```bash
   python -m venv venv
   venv\Scripts\activate  # On Windows
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the server:
   ```bash
   uvicorn main:app --reload
   ```

## Endpoints

- `POST /analyze-report/` — Upload a file for AI analysis (dummy model for now)
- `POST /chat/` — Send a message to the AI (dummy reply for now)

## Extending
- Replace the dummy model in `main.py` with your real ML/AI logic.
- Use the installed libraries (scikit-learn, torch, numpy, pandas) for your AI development.
